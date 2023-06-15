//
//  ProductsRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct ProductsRemoteService: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: ProductsRemoteService.self) { resolver in
            ProductsRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                 localeProvider: resolver.require((any AnyLocaleProvider).self))
        }
    }
    
    typealias ProductsError = ShopifyErrors<Any>
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    private let mapper = {
        var mapper: [ProductSearchCriteria: String] = [:]
        mapper[.tag] = "tag"
        mapper[.title] = "title"
        mapper[.type] = "product_type"
        mapper[.vendor] = "vendor"
        return mapper
    }()
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(withCriterion criterion: [ProductSearchCriteria:String],
               count: Int,
               with paginationInfo: PageInfo? = nil) async -> Result<PageResult<Product>, ProductsError> {
        let collectionId = criterion[.collection]
        if let collectionId = collectionId {
            return await fetch(withCollection: collectionId,
                               AndCriterion: criterion,
                               count: count,
                               with: paginationInfo)
        } else {
            return await fetch(withoutCollectionAndCriterion: criterion,
                               count: count,
                               with: paginationInfo)
        }
    }
    
    func fetch(withoutCollectionAndCriterion criterion: [ProductSearchCriteria:String],
               count: Int,
               with paginationInfo: PageInfo? = nil) async -> Result<PageResult<Product>, ProductsError> {
        var criterionQueries = [String]()
        for (key, value) in criterion.compactMapValues({$0}) {
            let query = "\(mapper[key]!):\(value)"
            criterionQueries.append(query)
        }
        let queryString = criterionQueries.joined(separator: " AND ")
        let query = ShopifyAPI.GetProductsByQuery(cursor: .init(nullable: paginationInfo?.nextCursor),
                                                  count: count,
                                                  query: queryString,
                                                  country: .init(nullable: localeProvider.shopifyCountry),
                                                  lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.products {
                let products = data.edges
                let pageInfo = data.pageInfo
                return .success(.init(list: products.map { Product(from: $0.node) },
                                      pageInfo: .init(nextCursor: pageInfo.endCursor,
                                                      hasNextCursor: pageInfo.hasNextPage)))
            } else {
                return .failure(ProductsError.Unknown)
            }
        }
    }
    
    func fetch(withCollection collectionId: String,
               AndCriterion criterion: [ProductSearchCriteria:String],
               count: Int,
               with paginationInfo: PageInfo? = nil) async -> Result<PageResult<Product>, ProductsError> {
        let query = ShopifyAPI.GetProductsByCollectionQuery(cursor: .init(nullable: paginationInfo?.nextCursor),
                                                            count: count,
                                                            collectionId: collectionId,
                                                            productType: .init(nullable: criterion[.type]),
                                                            productVendor: .init(nullable: criterion[.vendor]),
                                                            productTag: .init(nullable: criterion[.tag]),
                                                            country: .init(nullable: localeProvider.shopifyCountry),
                                                            lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data {
                if let data = data.collection?.products {
                    let products = data.edges
                    let pageInfo = data.pageInfo
                    return .success(.init(list: products.map { Product(from: $0.node) },
                                          pageInfo: .init(nextCursor: pageInfo.endCursor,
                                                          hasNextCursor: pageInfo.hasNextPage)))
                } else {
                    return .failure(ProductsError.NotFound)
                }
            } else {
                return .failure(ProductsError.Unknown)
            }
        }
    }
}
