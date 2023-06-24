//
//  MockRemoteClient.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
import Apollo
@testable import Shopify_ITI

protocol MockGraphQLResultFactory {
    func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error>
}

class MockRemoteClient: GraphQLClient {
    
    var client: GraphQLClient? = nil
    
    var fetchResult: MockGraphQLResultFactory! = nil
    
    var executeResult: MockGraphQLResultFactory! = nil
    
    func fetch<Query: GraphQLQuery>(query: Query,
                                    cachePolicy: GraphQLFetchPolicy?,
                                    operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error> {
        if let client = client {
            return await client.fetch(query: query, cachePolicy: cachePolicy, operation: &operation)
        } else {
            return fetchResult.get(Query.self)
        }
    }
    
    func execute<Query: GraphQLMutation>(query: Query,
                                         operation: inout GraphQLCancellable?) async -> Result<GraphQLResult<Query.Data>, Error> {
        if let client = client {
            return await client.execute(query: query, operation: &operation)
        } else {
            return executeResult.get(Query.self)
        }
    }
}
