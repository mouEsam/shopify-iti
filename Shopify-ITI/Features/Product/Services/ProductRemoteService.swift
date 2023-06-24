//
//  ProductRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation
import Shopify_ITI_SDK

// Id eg.: gid://shopify/Product/8341864055063

protocol AnyProductRemoteService {
    typealias ProductError = ShopifyErrors<Any>
    
    func fetch(byId id: String,
               collectionsCount: Int,
               imagesCount: Int,
               variantsCount: Int) async -> Result<DetailedProduct, ProductError>
}


struct ProductRemoteService: AnyProductRemoteService, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: ProductRemoteService.self) { resolver in
            ProductRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                localeProvider: resolver.require((any AnyLocaleProvider).self))
        }.implements(AnyProductRemoteService.self)
    }
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(byId id: String,
               collectionsCount: Int,
               imagesCount: Int,
               variantsCount: Int) async -> Result<DetailedProduct, ProductError> {
        let query = ShopifyAPI.GetProductByIdQuery(id: id,
                                                   collectionsCount: collectionsCount,
                                                   imagesCount: imagesCount,
                                                   variantsCount: variantsCount,
                                                   metaFieldsIdentifiers: [],
                                                   country: .init(nullable: localeProvider.shopifyCountry),
                                                   lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data {
                if let product = data.product {
                    return .success(DetailedProduct(from: product))
                } else {
                    return .failure(ProductError.NotFound)
                }
            } else {
                return .failure(ProductError.Unknown)
            }
        }
    }
}
