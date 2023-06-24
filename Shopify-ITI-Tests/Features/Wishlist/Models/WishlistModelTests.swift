//
//  WishlistModelTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class WishlistModelTests: XCTestCase {
    
    private var configsProvider: ConfigsProvider!
    private var userProvider: MockUserProvider!
    private var localeProvider: MockLocaleProvider!
    private var remoteService: MockWishlistRemoteService!
    private var model: WishlistModel!
    
    private let wishlist = Wishlist(id: "gid://shopify/DraftOrder/1119584420119",
                                    customerId: nil,
                                    tags: [],
                                    totalCount: 0,
                                    entries: [:])
    
    override func setUp() {
        configsProvider = ConfigsProvider()
        remoteService = MockWishlistRemoteService()
        localeProvider = MockLocaleProvider()
        userProvider = MockUserProvider()
        model = WishlistModel(wishlistService: remoteService,
                              configsProvider: configsProvider)
    }
    
    func testFetchSuccess() async {
        remoteService.fetchItemsResult = .success(PageResult(list: [],
                                                             pageInfo: PageInfo(nextCursor: nil,
                                                                                hasNextCursor: false)))
        
        let result = await model.fetch(for: wishlist.id)
        
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchNotFound() async {
        remoteService.fetchItemsResult = .failure(.NotFound)
        
        let result = await model.fetch(for: wishlist.id)
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchClientError() async {
        remoteService.fetchItemsResult = .failure(.Client(error: MockError()))
        
        let result = await model.fetch(for: wishlist.id)
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchActualSuccess() async {
        let client = ApolloGraphQLClient(environment: AdminEnvironmentProvider())
        remoteService.service = WishlistRemoteService(remoteClient: client,
                                                      localeProvider: localeProvider,
                                                      userProvider: userProvider)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await model.fetch(for: wishlist.id)
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
