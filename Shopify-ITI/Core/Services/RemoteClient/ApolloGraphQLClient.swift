//
//  ApolloGraphQLClient.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation
import Apollo

extension GraphQLFetchPolicy {
    fileprivate func mapToApollo() -> CachePolicy {
        switch self {
            case .prioritizeCache:
                return .returnCacheDataElseFetch
            case .prioritizeFetch:
                return .fetchIgnoringCacheData
            case .noCaching:
                return .fetchIgnoringCacheCompletely
            case .noFetch:
                return .returnCacheDataDontFetch
        }
    }
}

struct ApolloGraphQLClient: GraphQLClient {
    static func register(_ container: AppContainer) {
        container.register(type: (any GraphQLClient).self) { resolver in
            ApolloGraphQLClient(environment: resolver.require((any AnyEnvironmentProvider).self))
        }
        container.register(type: (any GraphQLClient).self,
                           name: AdminEnvironmentProvider.diName) { resolver in
            ApolloGraphQLClient(environment: resolver.require((any AnyEnvironmentProvider).self,
                                                              name: AdminEnvironmentProvider.diName))
        }
    }
    
    private let environment: any AnyEnvironmentProvider
    private let client: ApolloClient
    private let queue: DispatchQueue
    private let defaultCachePolicy: GraphQLFetchPolicy
    
    init(environment: some AnyEnvironmentProvider,
         client: ApolloClient,
         queue: DispatchQueue,
         defaultCachePolicy: GraphQLFetchPolicy) {
        self.environment = environment
        self.client = client
        self.queue = queue
        self.defaultCachePolicy = defaultCachePolicy
    }
    
    init(environment: some AnyEnvironmentProvider) {
        self.environment = environment
        
        let url = URL(string: environment.shopifyBaseUrl)!
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let provider = ApolloInterceptorsProvider(innerProvider: DefaultInterceptorProvider(store: store),
                                                  additionalInterceptors: [])
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url,
                                                     additionalHeaders: [environment.shopifyAccessTokenHeader: environment.shopifyAccessToken])
        self.client = ApolloClient(networkTransport: transport, store: store)
        self.queue = DispatchQueue(label: "ApolloGraphQLClient", qos: .userInitiated, attributes: .concurrent)
        self.defaultCachePolicy = .prioritizeFetch
    }
    
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: GraphQLFetchPolicy?,
                                    operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error> {
        let cachePolicy = cachePolicy ?? self.defaultCachePolicy
        return await withCheckedContinuation { continuation in
            operation = self.client.fetch(query: query,
                                          cachePolicy: cachePolicy.mapToApollo(),
                                          queue: self.queue) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    func execute<Query: GraphQLMutation>(query: Query,
                                         operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error> {
        return await withCheckedContinuation { continuation in
            operation = self.client.perform(mutation: query,
                                            queue: self.queue) { result in
                continuation.resume(returning: result)
            }
        }
    }
}

class ApolloInterceptorsProvider: InterceptorProvider {
    private let innerProvider: any InterceptorProvider
    private var additionalInterceptors: [any ApolloInterceptor]
    
    init(innerProvider: some InterceptorProvider,
         additionalInterceptors: [any ApolloInterceptor]) {
        self.innerProvider = innerProvider
        self.additionalInterceptors = additionalInterceptors
    }
    
    func interceptors<Operation : Apollo.GraphQLOperation>(for operation: Operation) -> [Apollo.ApolloInterceptor] {
        var list = additionalInterceptors
        list.append(contentsOf: innerProvider.interceptors(for: operation))
        return list
    }
}

class ApolloHeaderInterceptor: ApolloInterceptor {
    private let headers: [String: String]
    
    init(headers: [String: String]) {
        self.headers = headers
    }
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) {
        for (name, value) in headers {
            request.addHeader(name: name, value: value)
        }
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
