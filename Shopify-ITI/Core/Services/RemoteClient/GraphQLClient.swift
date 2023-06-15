//
//  GraphQLClient.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation
import Apollo

typealias GraphQLCancellable = Apollo.Cancellable

enum GraphQLFetchPolicy {
    case prioritizeCache
    case prioritizeFetch
    case noCaching
    case noFetch
}

protocol GraphQLClient: AnyInjectable {
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: GraphQLFetchPolicy?,
                                    operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error>
    func execute<Query: GraphQLMutation>(query: Query,
                                         operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error>
}

extension GraphQLClient {
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: GraphQLFetchPolicy? = nil) async -> Result<GraphQLResult<Query.Data>, Error> {
        var cancellable: GraphQLCancellable?
        return await fetch(query: query, cachePolicy: cachePolicy, operation: &cancellable)
    }
    
    func execute<Query: GraphQLMutation>(query: Query) async -> Result<GraphQLResult<Query.Data>, Error> {
        var cancellable: GraphQLCancellable?
        return await execute(query: query, operation: &cancellable)
    }
}
