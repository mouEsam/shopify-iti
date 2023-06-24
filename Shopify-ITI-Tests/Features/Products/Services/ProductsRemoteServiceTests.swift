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
    
    struct ProductsWithoutCollection: MockGraphQLResultFactory {
        
        var returnSuccess: Bool?
        
        func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
            if returnSuccess != false {
                let data = returnSuccess == true ?
                JSONObject([
                    ("products", JSONObject([
                        ("__typename", JSONValue("Product")),
                        ("edges", [JSONObject]()),
                        ("pageInfo", JSONObject([
                            ("__typename", JSONValue("PageInfo")),
                            ("hasPreviousPage", JSONValue(true)),
                            ("hasNextPage", JSONValue(true))
                        ]))
                    ]))
                ]) : nil
                return .success(.init(data: data.map { try! .init(data: $0, variables:[:]) },
                                      extensions: nil,
                                      errors: nil,
                                      source: .cache,
                                      dependentKeys: nil))
            } else {
                return .failure(MockError())
            }
        }
    }
    
    func testFetchWithoutCollectionSuccess() async {
        client.fetchResult = ProductsWithoutCollection(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionFailure() async {
        client.fetchResult = ProductsWithoutCollection(returnSuccess: false)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionClientFailure() async {
        client.fetchResult = ProductsWithoutCollection(returnSuccess: false)
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
    
    struct ProductsWithCollection: MockGraphQLResultFactory {
        
        var returnSuccess: Bool?
        
        func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
            if returnSuccess != false {
                let data = returnSuccess == true ?
                JSONObject([
                    ("collection", JSONObject([
                        ("__typename", JSONValue("Collection")),
                        ("products", JSONObject([
                            ("__typename", JSONValue("Product")),
                            ("edges", [JSONObject]()),
                            ("pageInfo", JSONObject([
                                ("__typename", JSONValue("PageInfo")),
                                ("hasPreviousPage", JSONValue(true)),
                                ("hasNextPage", JSONValue(true))
                            ]))
                        ]))
                    ]))
                ]) : nil
                return .success(.init(data: data.map { try! .init(data: $0, variables:[:]) },
                                      extensions: nil,
                                      errors: nil,
                                      source: .cache,
                                      dependentKeys: nil))
            } else {
                return .failure(MockError())
            }
        }
    }
    
    func testFetchWithCollectionSuccess() async {
        client.fetchResult = ProductsWithCollection(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCollection: "gid://shopify/Collection/446652317975",
                                               AndCriterion: [:],
                                               count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithCollectionFailure() async {
        client.fetchResult = ProductsWithCollection(returnSuccess: nil)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCollection: "gid://shopify/Collection/446652317975",
                                               AndCriterion: [:],
                                               count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithCollectionClientFailure() async {
        client.fetchResult = ProductsWithCollection(returnSuccess: false)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCollection: "gid://shopify/Collection/446652317975",
                                               AndCriterion: [:],
                                               count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithCollectionActualSuccess() async {
        client.client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCollection: "gid://shopify/Collection/446652317975",
                                               AndCriterion: [:],
                                               count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    struct ProductsWithQuery: MockGraphQLResultFactory {
        
        var returnSuccess: Bool?
        
        func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
            if returnSuccess != false {
                let data = returnSuccess == true ?
                JSONObject([
                    ("search", JSONObject([
                        ("__typename", JSONValue("Search")),
                        ("edges", [JSONObject]()),
                        ("pageInfo", JSONObject([
                            ("__typename", JSONValue("PageInfo")),
                            ("hasPreviousPage", JSONValue(true)),
                            ("hasNextPage", JSONValue(true))
                        ]))
                    ]))
                ]) : nil
                return .success(.init(data: data.map { try! .init(data: $0, variables:[:]) },
                                      extensions: nil,
                                      errors: nil,
                                      source: .cache,
                                      dependentKeys: nil))
            } else {
                return .failure(MockError())
            }
        }
    }
    
    func testFetchWithQuerySuccess() async {
        client.fetchResult = ProductsWithQuery(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withQuery: "VANS", count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithQueryFailure() async {
        client.fetchResult = ProductsWithQuery(returnSuccess: nil)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withQuery: "VANS", count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithQueryClientFailure() async {
        client.fetchResult = ProductsWithQuery(returnSuccess: false)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withQuery: "VANS", count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithQueryActualSuccess() async {
        client.client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withQuery: "VANS", count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchQuery() async {
        client.fetchResult = ProductsWithQuery(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.query: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchCollection() async {
        client.fetchResult = ProductsWithCollection(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.collection: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchQueryWithCriterion() async {
        client.fetchResult = ProductsWithoutCollection(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.query: "VANS", .type: "SHOES"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchCollectionWithCriterion() async {
        client.fetchResult = ProductsWithCollection(returnSuccess: true)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.collection: "VANS", .type: "SHOES"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
