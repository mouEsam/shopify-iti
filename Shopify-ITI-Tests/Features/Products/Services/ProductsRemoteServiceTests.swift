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
    
    private let errorResult = MockGraphQLResult.ResultType.clientError(error: MockError())
    
    private let productsWithoutCollectionSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
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
    
    private let productsWithCollectionSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
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
    ]))
    
    private let productsWithQuerySuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("search", JSONObject([
            ("__typename", JSONValue("Search")),
            ("edges", [JSONObject]()),
            ("pageInfo", JSONObject([
                ("__typename", JSONValue("PageInfo")),
                ("hasPreviousPage", JSONValue(true)),
                ("hasNextPage", JSONValue(true))
            ]))
        ]))
    ]))
    
    override func setUp() {
        client = MockRemoteClient()
        localeProvider = MockLocaleProvider()
        remoteService = .init(remoteClient: client,
                              localeProvider: localeProvider)
    }
    
    func testFetchWithoutCollectionSuccess() async {
        client.fetchResult = MockGraphQLResult(result: productsWithoutCollectionSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionFailure() async {
        client.fetchResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withoutCollectionAndCriterion: [.query: "VANS"], count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithoutCollectionClientFailure() async {
        client.fetchResult = MockGraphQLResult(result: .error)
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
    
    func testFetchWithCollectionSuccess() async {
        client.fetchResult = MockGraphQLResult(result: productsWithCollectionSuccessResult)
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
        client.fetchResult = MockGraphQLResult(result: errorResult)
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
        client.fetchResult = MockGraphQLResult(result: .notFound)
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
    
    func testFetchWithQuerySuccess() async {
        client.fetchResult = MockGraphQLResult(result: productsWithQuerySuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withQuery: "VANS", count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithQueryFailure() async {
        client.fetchResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withQuery: "VANS", count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchWithQueryClientFailure() async {
        client.fetchResult = MockGraphQLResult(result: .error)
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
        client.fetchResult = MockGraphQLResult(result: productsWithQuerySuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.query: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchCollection() async {
        client.fetchResult = MockGraphQLResult(result: productsWithCollectionSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.collection: "VANS"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchQueryWithCriterion() async {
        client.fetchResult = MockGraphQLResult(result: productsWithoutCollectionSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.query: "VANS", .type: "SHOES"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchCollectionWithCriterion() async {
        client.fetchResult = MockGraphQLResult(result: productsWithCollectionSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.collection: "VANS", .type: "SHOES"], count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
