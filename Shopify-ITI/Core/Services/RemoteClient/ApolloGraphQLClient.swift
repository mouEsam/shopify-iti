//
//  ApolloGraphQLClient.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation
import Apollo

/*
 curl -X POST \
 https://18c640d114bd302801f792ba0f7432aa:74fc3fc4ffb7889a033a7ab71b34499d@mad43-alex-ios-team1.myshopify.com/api/2022-01/graphql.json \
 -H 'Content-Type: application/graphql' \
 -H 'X-Shopify-Storefront-Access-Token: 74fc3fc4ffb7889a033a7ab71b34499d' \
 -d 'query { products(first: 10) { edges { cursor node { title } } } }'
 */

struct ApolloGraphQLClient: GraphQLClient {
    private let environment: any AnyEnvironmentProvider
    private let client: ApolloClient
    private let queue: DispatchQueue
    
    init(environment: some AnyEnvironmentProvider,
         client: ApolloClient,
         queue: DispatchQueue) {
        self.environment = environment
        self.client = client
        self.queue = queue
    }
    
    init(environment: some AnyEnvironmentProvider) {
        self.environment = environment
        
        let url = URL(string: environment.shopifyBaseUrl)!
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let headersInterceptor = ApolloHeaderInterceptor(headers: [environment.shopifyAccessTokenHeader: environment.shopifyAccessToken])
        let provider = ApolloInterceptorsProvider(innerProvider: DefaultInterceptorProvider(store: store),
                                                  additionalInterceptors: [headersInterceptor])
        let transport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                     endpointURL: url)
        self.client = ApolloClient(networkTransport: transport, store: store)
        self.queue = DispatchQueue(label: "ApolloGraphQLClient", qos: .userInitiated, attributes: .concurrent)
    }
    
    func fetch<Query: GraphQLQuery>(query: Query, operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error> {
        return await withCheckedContinuation { continuation in
            operation = self.client.fetch(query: query, queue: self.queue) { result in
                continuation.resume(returning: result)
            }
        }
    }
    
    func execute<Query: GraphQLMutation>(query: Query, operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error> {
        return await withCheckedContinuation { continuation in
            operation = self.client.perform(mutation: query, queue: self.queue) { result in
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
