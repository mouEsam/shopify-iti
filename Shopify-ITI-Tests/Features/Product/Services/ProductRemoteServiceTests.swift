//
//  ProductRemoteServiceTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class ProductRemoteServiceTests: XCTestCase {
    
    private var client: MockRemoteClient!
    private var localeProvider: MockLocaleProvider!
    private var remoteService: ProductRemoteService!
    
    override func setUp() {
        client = MockRemoteClient()
        localeProvider = MockLocaleProvider()
        remoteService = .init(remoteClient: client,
                              localeProvider: localeProvider)
    }
    
    struct Product: MockGraphQLResultFactory {
        enum ResultType {
            case found
            case notFound
            case error
            case clientError
        }
        
        var result: ResultType
        
        func get<Query: GraphQLOperation>(_ type: Query.Type) -> Result<GraphQLResult<Query.Data>, Error> {
            var data: JSONObject?
            switch result {
                case .found:
                    data = JSONObject([
                        ("product", JSONObject([
                            ("__typename", JSONValue("Product")),
                            ("id", JSONValue("id")),
                            ("handle", JSONValue("handle")),
                            ("title", JSONValue("title")),
                            ("description", JSONValue("description")),
                            ("availableForSale", JSONValue(true)),
                            ("compareAtPriceRange", JSONObject([
                                ("__typename", JSONValue("CompareAtPriceRange")),
                                ("maxVariantPrice", JSONObject([
                                    ("__typename", JSONValue("MaxVariantPrice")),
                                    ("amount", JSONValue("00")),
                                    ("currencyCode", JSONValue("EGP")),
                                ])),
                                ("minVariantPrice", JSONObject([
                                    ("__typename", JSONValue("MaxVariantPrice")),
                                    ("amount", JSONValue("00")),
                                    ("currencyCode", JSONValue("EGP")),
                                ]))
                            ])),
                            ("priceRange", JSONObject([
                                ("__typename", JSONValue("PriceRange")),
                                ("maxVariantPrice", JSONObject([
                                    ("__typename", JSONValue("MaxVariantPrice")),
                                    ("amount", JSONValue("00")),
                                    ("currencyCode", JSONValue("EGP")),
                                ])),
                                ("minVariantPrice", JSONObject([
                                    ("__typename", JSONValue("MaxVariantPrice")),
                                    ("amount", JSONValue("00")),
                                    ("currencyCode", JSONValue("EGP")),
                                ]))
                            ])),
                            ("tags", [JSONObject]()),
                            ("vendor", JSONValue("vendor")),
                            ("options", [JSONObject]()),
                            ("metafields", [JSONObject]()),
                            ("collections", JSONObject([
                                ("__typename", JSONValue("Collection")),
                                ("nodes", [JSONObject]())
                            ])),
                            ("images", JSONObject([
                                ("__typename", JSONValue("Image")),
                                ("nodes", [JSONObject]())
                            ])),
                            ("variants", JSONObject([
                                ("__typename", JSONValue("ProductVariant")),
                                ("nodes", [JSONObject]())
                            ]))
                        ]))
                    ])
                    break
                case .notFound:
                    data = JSONObject([])
                    break
                case .error:
                    data = nil
                    break
                case .clientError:
                    return .failure(MockError())
            }
            return .success(.init(data: data.map { try! .init(data: $0, variables:[:]) },
                                  extensions: nil,
                                  errors: nil,
                                  source: .cache,
                                  dependentKeys: nil))
        }
    }
    
    func testFetchSuccess() async {
        client.fetchResult = Product(result: .found)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(byId: "gid://shopify/Product/8341863858455",
                                               collectionsCount: 10,
                                               imagesCount: 10,
                                               variantsCount: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testFetchFailure() async {
        client.fetchResult = Product(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(byId: "gid://shopify/Product/8341863858455",
                                               collectionsCount: 10,
                                               imagesCount: 10,
                                               variantsCount: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchNotFoundFailure() async {
        client.fetchResult = Product(result: .notFound)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(byId: "gid://shopify/Product/8341863858455",
                                               collectionsCount: 10,
                                               imagesCount: 10,
                                               variantsCount: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchClientFailure() async {
        client.fetchResult = Product(result: .clientError)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(byId: "gid://shopify/Product/8341863858455",
                                               collectionsCount: 10,
                                               imagesCount: 10,
                                               variantsCount: 10)
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testFetchActualSuccess() async {
        client.client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.fetch(byId: "gid://shopify/Product/8341863858455",
                                               collectionsCount: 10,
                                               imagesCount: 10,
                                               variantsCount: 10)
        if case .failure(_) = result {
            XCTFail()
        }
    }
}
