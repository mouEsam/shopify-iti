//
//  WishlistRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class WishlistRemoteServiceTests: XCTestCase {
    
    private var client: MockRemoteClient!
    private var localeProvider: MockLocaleProvider!
    private var userProvider: MockUserProvider!
    private var remoteService: WishlistRemoteService!
    
    private let user = User(id: "gid://shopify/Customer/7029803778327",
                            displayName: "User",
                            firstName: "User",
                            lastName: "",
                            email: "user@test.com",
                            phone: "")
    
    private let wishlist = Wishlist(id: "gid://shopify/DraftOrder/1119062425879",
                                    customerId: nil,
                                    tags: [],
                                    totalCount: 0,
                                    entries: [:])
    
    private let errorResult = MockGraphQLResult.ResultType.clientError(error: MockError())
    
    private let wishlistSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("draftOrders", JSONObject([
            ("__typename", JSONValue("DraftOrder")),
            ("nodes", [
                JSONObject([
                    ("__typename", JSONValue("DraftOrder")),
                    ("id", JSONValue("id")),
                    ("createdAt", JSONValue("2019-09-07T-15:50+00")),
                    ("currencyCode", JSONValue("EGP")),
                    ("subtotalPriceSet", JSONObject([
                        ("__typename", JSONValue("SubtotalPriceSet")),
                        ("presentmentMoney", JSONObject([
                            ("__typename", JSONValue("PresentmentMoney")),
                            ("amount100", JSONValue("00")),
                            ("currencyCode", JSONValue("EGP")),
                        ])),
                    ])),
                    ("totalPriceSet", JSONObject([
                        ("__typename", JSONValue("TotalPriceSet")),
                        ("presentmentMoney", JSONObject([
                            ("__typename", JSONValue("PresentmentMoney")),
                            ("amount100", JSONValue("00")),
                            ("currencyCode", JSONValue("EGP")),
                        ])),
                    ])),
                    ("tags", [String]()),
                    ("lineItems", JSONObject([
                        ("__typename", JSONValue("DraftOrderLine")),
                        ("pageInfo", JSONObject([
                            ("__typename", JSONValue("PageInfo")),
                            ("hasPreviousPage", JSONValue(false)),
                            ("hasNextPage", JSONValue(false))
                        ])),
                        ("nodes", [JSONObject]()),
                    ])),
                ])
            ]),
        ]))
    ]))
    
    private let wishlistNotfoundResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("draftOrders", JSONObject([
            ("__typename", JSONValue("DraftOrder")),
            ("nodes", [JSONObject]()),
        ]))
    ]))
    
    private let wishlistByIdSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("draftOrder", JSONObject([
            ("__typename", JSONValue("DraftOrder")),
            ("id", JSONValue("id")),
            ("createdAt", JSONValue("2019-09-07T-15:50+00")),
            ("currencyCode", JSONValue("EGP")),
            ("subtotalPriceSet", JSONObject([
                ("__typename", JSONValue("SubtotalPriceSet")),
                ("presentmentMoney", JSONObject([
                    ("__typename", JSONValue("PresentmentMoney")),
                    ("amount100", JSONValue("00")),
                    ("currencyCode", JSONValue("EGP")),
                ])),
            ])),
            ("totalPriceSet", JSONObject([
                ("__typename", JSONValue("TotalPriceSet")),
                ("presentmentMoney", JSONObject([
                    ("__typename", JSONValue("PresentmentMoney")),
                    ("amount100", JSONValue("00")),
                    ("currencyCode", JSONValue("EGP")),
                ])),
            ])),
            ("tags", [String]()),
            ("lineItems", JSONObject([
                ("__typename", JSONValue("DraftOrderLine")),
                ("pageInfo", JSONObject([
                    ("__typename", JSONValue("PageInfo")),
                    ("hasPreviousPage", JSONValue(false)),
                    ("hasNextPage", JSONValue(false))
                ])),
                ("nodes", [JSONObject]()),
            ])),
        ]))
    ]))
    
    private let deleteWishlistSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("draftOrderDelete", JSONObject([
            ("__typename", JSONValue("DraftOrderDelete")),
            ("deletedId", JSONValue("id")),
            ("userErrors", [JSONObject]()),
        ])),
    ]))
    
    private let createWishlistSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("draftOrderCreate", JSONObject([
            ("__typename", JSONValue("DraftOrderCreate")),
            ("draftOrder", JSONObject([
                ("__typename", JSONValue("DraftOrder")),
                ("id", JSONValue("id")),
                ("createdAt", JSONValue("2019-09-07T-15:50+00")),
                ("currencyCode", JSONValue("EGP")),
                ("subtotalPriceSet", JSONObject([
                    ("__typename", JSONValue("SubtotalPriceSet")),
                    ("presentmentMoney", JSONObject([
                        ("__typename", JSONValue("PresentmentMoney")),
                        ("amount100", JSONValue("00")),
                        ("currencyCode", JSONValue("EGP")),
                    ])),
                ])),
                ("totalPriceSet", JSONObject([
                    ("__typename", JSONValue("TotalPriceSet")),
                    ("presentmentMoney", JSONObject([
                        ("__typename", JSONValue("PresentmentMoney")),
                        ("amount100", JSONValue("00")),
                        ("currencyCode", JSONValue("EGP")),
                    ])),
                ])),
                ("tags", [String]()),
                ("lineItems", JSONObject([
                    ("__typename", JSONValue("DraftOrderLine")),
                    ("pageInfo", JSONObject([
                        ("__typename", JSONValue("PageInfo")),
                        ("hasPreviousPage", JSONValue(false)),
                        ("hasNextPage", JSONValue(false))
                    ])),
                    ("nodes", [JSONObject]()),
                ])),
            ])),
            ("userErrors", [JSONObject]()),
        ])),
    ]))
    
    private let wishlistItemsSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("draftOrder", JSONObject([
            ("__typename", JSONValue("DraftOrder")),
            ("id", JSONValue("id")),
            ("createdAt", JSONValue("2019-09-07T-15:50+00")),
            ("currencyCode", JSONValue("EGP")),
            ("subtotalPriceSet", JSONObject([
                ("__typename", JSONValue("SubtotalPriceSet")),
                ("presentmentMoney", JSONObject([
                    ("__typename", JSONValue("PresentmentMoney")),
                    ("amount100", JSONValue("00")),
                    ("currencyCode", JSONValue("EGP")),
                ])),
            ])),
            ("totalPriceSet", JSONObject([
                ("__typename", JSONValue("TotalPriceSet")),
                ("presentmentMoney", JSONObject([
                    ("__typename", JSONValue("PresentmentMoney")),
                    ("amount100", JSONValue("00")),
                    ("currencyCode", JSONValue("EGP")),
                ])),
            ])),
            ("tags", [String]()),
            ("lineItems", JSONObject([
                ("__typename", JSONValue("DraftOrderLine")),
                ("pageInfo", JSONObject([
                    ("__typename", JSONValue("PageInfo")),
                    ("hasPreviousPage", JSONValue(false)),
                    ("hasNextPage", JSONValue(false))
                ])),
                ("edges", [JSONObject]()),
            ])),
        ]))
    ]))
    
    override func setUp() {
        client = MockRemoteClient()
        localeProvider = MockLocaleProvider()
        userProvider = MockUserProvider()
        remoteService = .init(remoteClient: client,
                              localeProvider: localeProvider,
                              userProvider: userProvider)
    }
    
    func testFetchAutherizedSuccess() async {
        client.fetchResult = MockGraphQLResult(result: wishlistSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.fetch()
        if case .failure(_) = result {
            XCTFail()
        }
    }


    func testFetchUnAutherizedFailure() async {
        client.fetchResult = MockGraphQLResult(result: wishlistSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"

        let result = await remoteService.fetch()
        if case .success(_) = result {
            XCTFail()
        }
    }

    func testFetchNotFoundFailure() async {
        client.fetchResult = MockGraphQLResult(result: wishlistNotfoundResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.fetch()
        if case .success(_) = result {
            XCTFail()
        }
    }

    func testFetchClientFailure() async {
        client.fetchResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user

        let result = await remoteService.fetch()
        if case .success(_) = result {
            XCTFail()
        }
    }

    func testFetchActualSuccess() async {
        client.client = ApolloGraphQLClient(environment: AdminEnvironmentProvider())
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "EN"
        userProvider.userResult = user

        let result = await remoteService.fetch()
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    
    func testFetchByIdSuccess() async {
        client.fetchResult = MockGraphQLResult(result: wishlistByIdSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(by: "")
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchByIdNotFound() async {
        client.fetchResult = MockGraphQLResult(result: .notFound)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(by: "")
        dump(result)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchByIdClientError() async {
        client.fetchResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(by: "")
        dump(result)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchByIdActualSuccess() async {
        client.client = ApolloGraphQLClient(environment: AdminEnvironmentProvider())
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "EN"

        let result = await remoteService.fetch(by: wishlist.id)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testCreateSuccess() async {
        client.executeResult = MockGraphQLResult(result: createWishlistSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.create(with: .init(productId: "",
                                                            variantId: ""))
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testCreateClientError() async {
        client.executeResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.create(with: .init(productId: "",
                                                            variantId: ""))
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testCreateFailure() async {
        client.executeResult = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.create(with: .init(productId: "",
                                                            variantId: ""))
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testDeleteSuccess() async {
        client.executeResult = MockGraphQLResult(result: deleteWishlistSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.delete(wishlist: wishlist)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testDeleteClientError() async {
        client.executeResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.delete(wishlist: wishlist)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testDeleteFailure() async {
        client.executeResult = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.delete(wishlist: wishlist)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testUpdateSuccess() async {
        client.executeResult = MockGraphQLResult(result: createWishlistSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.update(list: wishlist)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testUpdateClientError() async {
        client.executeResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.update(list: wishlist)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testUpdateFailure() async {
        client.executeResult = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.update(list: wishlist)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchItemsSuccess() async {
        client.fetchResult = MockGraphQLResult(result: wishlistItemsSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.fetchItems(for: wishlist.id, count: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchItemsClientError() async {
        client.fetchResult = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.fetchItems(for: wishlist.id, count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchItemsFailure() async {
        client.fetchResult = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        userProvider.userResult = user
        
        let result = await remoteService.fetchItems(for: wishlist.id, count: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
}
