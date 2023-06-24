//
//  ProductModelTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class ProductModelTests: XCTestCase {
    
    private var configsProvider: ConfigsProvider!
    private var localeProvider: MockLocaleProvider!
    private var remoteService: MockProductRemoteService!
    private var model: ProductModel!
    
    override func setUp() {
        configsProvider = ConfigsProvider()
        remoteService = MockProductRemoteService()
        localeProvider = MockLocaleProvider()
        model = ProductModel(remoteService: remoteService,
                             configsProvider: configsProvider)
    }
    
    private func mockProduct() -> DetailedProduct {
        DetailedProduct(id: "",
                        handle: "",
                        title: "",
                        description: "",
                        featuredImage: nil,
                        availableForSale: false,
                        compareAtPriceRange: .init(minPrice: .init(amount: 0, currencyCode: .egp),
                                                   maxPrice: .init(amount: 0, currencyCode: .egp)),
                        metafields: [],
                        priceRange: .init(minPrice: .init(amount: 0, currencyCode: .egp),
                                          maxPrice: .init(amount: 0, currencyCode: .egp)),
                        tags: [],
                        totalInventory: nil,
                        vendor: "",
                        options: [],
                        collections: [],
                        images: [],
                        variants: [])
    }
    
    func testFetchSuccess() async {
        remoteService.fetchResult = .success(mockProduct())
        
        let result = await model.fetch(byId: "")
        
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchNotFound() async {
        remoteService.fetchResult = .failure(.NotFound)
        
        let result = await model.fetch(byId: "")
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchClientError() async {
        remoteService.fetchResult = .failure(.Client(error: MockError()))
        
        let result = await model.fetch(byId: "")
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchActualSuccess() async {
        let client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        remoteService.service = ProductRemoteService(remoteClient: client,
                                                     localeProvider: localeProvider)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await model.fetch(byId: "gid://shopify/Product/8341863858455")
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
