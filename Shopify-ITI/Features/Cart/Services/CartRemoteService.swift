//
//  CartRemoteService.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct CartRemoteService:AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (CartRemoteService).self) { resolver in
            CartRemoteService(remoteClient:resolver.require((any GraphQLClient).self),
                              localeProvider: resolver.require((any AnyLocaleProvider).self))
        }
    }
    
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
    func createCart(with cartInput: ShopifyAPI.CartInput) async -> Result<Cart?, Error> {
       
        let query = ShopifyAPI.CreateCartMutation(cartInput: .init(nullable: cartInput),
                                                  country:  .init(nullable: localeProvider.shopifyCountry),
                                                  lang:  .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.execute(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.cartCreate?.cart.map { cart in
                    print(cart)
                  return  Cart(from: cart)
                }
            }
        }
    }
    func upDate(card id: String,with lineInput: ShopifyAPI.CartLineInput) async -> Result<Cart?, Error> {
       
        let query = ShopifyAPI.AddCartLinesMutation(cartId: id,
                                                    lines: [lineInput],
                                                    country:  .init(nullable: localeProvider.shopifyCountry),
                                                    lang:  .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.execute(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.cartLinesAdd?.cart.map { cart in
                    Cart(from: cart)
                }
            }
        }
    }
    func upDateLineFor( card id: String,with lineInput: ShopifyAPI.CartLineUpdateInput) async -> Result<Cart?, Error> {
       
        let query = ShopifyAPI.UpdateCartLinesMutation(cartId: id,
                                                    lines: [lineInput],
                                                    country:  .init(nullable: localeProvider.shopifyCountry),
                                                    lang:  .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.execute(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.cartLinesUpdate?.cart.map { cart in
                    Cart(from: cart)
                }
            }
        }
    }
    func removeLine(withLineID lineId: String,forCart cartId: String) async -> Result<Cart?, Error> {
       
        let query = ShopifyAPI.RemoveCartLinesMutation(cartId: cartId,
                                                       lineIds: [lineId],
                                                       country:  .init(nullable: localeProvider.shopifyCountry),
                                                       lang:  .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.execute(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.cartLinesRemove?.cart.map { cart in
                    Cart(from: cart)
                }
            }
        }
    }
    func upDataBuyerIdentity(withUserID userId: String?,forCart cartId: String) async -> Result<Cart?, Error> {
        let buyerIdentity = ShopifyAPI.CartBuyerIdentityInput(customerAccessToken: .init(nullable: userId))
        let query = ShopifyAPI.UpdateCartBuyerIdentityMutation(buyerIdentity: buyerIdentity,
                                                               cartId: cartId,
                                                               country:  .init(nullable: localeProvider.shopifyCountry),
                                                               lang:  .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.execute(query: query)
        return result.map { result in
            result.data.flatMap { data in
                data.cartBuyerIdentityUpdate?.cart.map { cart in
                    Cart(from: cart)
                }
            }
        }
    }
}
