//
//  MockGraphQLResult.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
import Apollo

struct MockGraphQLResult: MockGraphQLResultFactory {
    enum ResultType {
        case found(data: JSONObject)
        case notFound
        case error
        case clientError(error: Error)
    }
    
    var result: ResultType
    
    func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
        var data: JSONObject?
        switch result {
            case .found(let json):
                data = json
                break
            case .notFound:
                data = JSONObject([])
                break
            case .error:
                data = nil
                break
            case .clientError(let error):
                return .failure(error)
        }
        return .success(.init(data: data.map { try! .init(data: $0, variables:[:]) },
                              extensions: nil,
                              errors: nil,
                              source: .cache,
                              dependentKeys: nil))
    }
}

