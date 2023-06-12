//
//  GraphQLClient.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation
import Apollo

typealias GraphQLCancellable = Apollo.Cancellable

protocol GraphQLClient: AnyInjectable {
    func fetch<Query: GraphQLQuery>(query: Query,
                                    operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error>
    func execute<Query: GraphQLMutation>(query: Query,
                                         operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error>
}

extension GraphQLClient {
    func fetch<Query: GraphQLQuery>(query: Query) async -> Result<GraphQLResult<Query.Data>, Error> {
        var cancellable: GraphQLCancellable?
        return await fetch(query: query, operation: &cancellable)
    }
    
    func execute<Query: GraphQLMutation>(query: Query) async -> Result<GraphQLResult<Query.Data>, Error> {
        var cancellable: GraphQLCancellable?
        return await execute(query: query, operation: &cancellable)
    }
}
