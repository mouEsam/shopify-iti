//
//  CartRemoteService.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct CartRemoteService {
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider
        ) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(byId id: String) async -> Result<Cart?, Error> {
        let query = ShopifyAPI.GetCartQuery.init(cartId: id,
                                                 country:  .init(nullable: localeProvider.shopifyCountry),
                                                 lang:  .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.cart.map { cart in
                    Cart(from: cart)
                }
            }
        }
    }
}
