//
//  ProductsModelTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class ProductsModelTests: XCTestCase {
    
    private var configsProvider: ConfigsProvider!
    private var remoteService: MockProductsRemoteService!
    private var model: ProductsModel!
    
    override func setUp() {
        configsProvider = ConfigsProvider()
        remoteService = MockProductsRemoteService()
        model = ProductsModel(productsService: remoteService,
                              configsProvider: configsProvider)
    }
    
    func testFetchSuccess() async {
        remoteService.fetchWithCriterionResult = .success(PageResult(list: [],
                                                                     pageInfo: PageInfo(nextCursor: nil,
                                                                           hasNextCursor: false)))
        
        let result = await model.fetch(withCriteria: [:])
        
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchNotFound() async {
        remoteService.fetchWithCriterionResult = .failure(.Unknown)
        
        let result = await model.fetch(withCriteria: [:])
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchClientError() async {
        remoteService.fetchWithCriterionResult = .failure(.Client(error: MockError()))
        
        let result = await model.fetch(withCriteria: [:])
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchActualSuccess() async {
        var localeProvider = MockLocaleProvider()
        var client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        remoteService.service = ProductsRemoteService(remoteClient: client,
                                                      localeProvider: localeProvider)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(withCriterion: [.query: "VANS"],
                                               count: 10,
                                               with: nil)
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
