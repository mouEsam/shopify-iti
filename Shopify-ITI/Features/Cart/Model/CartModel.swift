//
//  CartModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct CartModel:AnyCartModel{
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCartModel).self) { resolver in
            CartModel(cartRemoteService: resolver.require(CartRemoteService.self),checker: resolver.require(CartChecker.self))
        }
    }
    
    
    let cartRemoteService:CartRemoteService
    let checker:AnyCartChecker
    
    func getCart(with id: String) async -> Result<Cart?, Error> {
        return await cartRemoteService.fetch(byId: id)
    }
    
    func changeItemQuantity(forCart id: String,forLine lineId:String,with quantity:Int ) async -> Result<Cart?, Error> {
        if(quantity > 0){
            return await cartRemoteService.upDateLineFor(card: id,
                                                         with: ShopifyAPI.CartLineUpdateInput(id: lineId,quantity: .init(nullable: quantity)))
        }
        return .success(nil)
    }
    func deleteCartItem(forCart id: String,forLine lineId:String) async -> Result<Cart?, Error> {
        return await cartRemoteService.removeLine(with: id, for: lineId)
    }
    
    
}
