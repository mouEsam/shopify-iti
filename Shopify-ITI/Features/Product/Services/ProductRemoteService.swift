//
//  ProductRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation
import Shopify_ITI_SDK

// Id eg.: gid://shopify/Product/8341864055063

struct ProductRemoteService {
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    private let configsProvider: any AnyConfigsProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider,
         configsProvider: some AnyConfigsProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
        self.configsProvider = configsProvider
    }
    
    func fetch(byId id: String) async -> Result<DetailedProduct?, Error> {
        let query = ShopifyAPI.GetProductByIdQuery(id: id,
                                                   collectionsCount: configsProvider.collectionsCountInProductInfoPage,
                                                   imagesCount: configsProvider.imagesCountInProductInfoPage,
                                                   variantsCount: configsProvider.variantsCountInProductInfoPage,
                                                   metaFieldsIdentifiers: [],
                                                   country: .init(nullable: localeProvider.shopifyCountry),
                                                   lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.product.map { product in
                    DetailedProduct(from: product)
                }
            }
        }
    }
}
