//
//  ApolloGraphQLClient.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation
import Apollo

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
        self.client = ApolloClient(url: URL(string: environment.shopifyBaseUrl)!)
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
    
    private func test() async {
        let result = await fetch(query: ShopifyAPI.DummyQuery())
        if case .success(let data) = result {
            data.data?.products
        }
    }
}
