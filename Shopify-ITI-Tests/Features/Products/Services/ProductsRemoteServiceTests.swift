//
//  ProductsRemoteServiceTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class ProductsRemoteServiceTests: XCTestCase {

    private var client: MockRemoteClient!
    private var localeProvider: MockLocaleProvider!
    private var remoteService: ProductsRemoteService!
    
    override func setUp() {
        client = MockRemoteClient()
        localeProvider = MockLocaleProvider()
        remoteService = .init(remoteClient: client,
                              localeProvider: localeProvider)
    }
    
    func testFetchWithoutCollectionSuccess() async {
        struct ProductsWithoutCollection: MockGraphQLResultFactory {
            func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
                let data = JSONObject([
                    ("products", JSONObject([
                        ("__typename", JSONValue("Product")),
                        ("edges", [JSONObject]()),
                        ("pageInfo", JSONObject([
                            ("__typename", JSONValue("PageInfo")),
                            ("hasPreviousPage", JSONValue(true)),
                            ("hasNextPage", JSONValue(true))
                        ]))
                    ]))
                ])
                return .success(.init(data: try! .init(data: data, variables:[:]),
                                      extensions: nil,
                                      errors: nil,
                                      source: .cache,
                                      dependentKeys: nil))
            }
        }
        client.fetchResult = ProductsWithoutCollection()
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionFailure() async {
        struct ProductsWithoutCollection: MockGraphQLResultFactory {
            func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
                return .success(.init(data: .none,
                                      extensions: nil,
                                      errors: [],
                                      source: .cache,
                                      dependentKeys: nil))
            }
        }
        client.fetchResult = ProductsWithoutCollection()
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionClientFailure() async {
        struct ProductsWithoutCollection: MockGraphQLResultFactory {
            func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
                return .failure(MockError())
            }
        }
        client.fetchResult = ProductsWithoutCollection()
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionActualSuccess() async {
        client.client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
