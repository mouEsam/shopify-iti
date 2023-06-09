//
//  ProductsRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct ProductsRemoteService {
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
    
    func fetch(cursor: String?) async -> Result<DetailedProduct?, Error> {
        let query = ShopifyAPI.GetProductsByQuery(after: .init(nullable: cursor),
                                                  first: configsProvider.productsCountPerPage,
                                                  query: "",
                                                  country: .init(nullable: localeProvider.shopifyCountry),
                                                  lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.map { result in
            result.data.flatMap { data in
                let mappedData = data.products.edges.map { edge in
                    (edge.cursor, edge.node)
                }
                (mappedData.last, mappedData.map(\.1))
                return nil
            }
        }
    }
}
