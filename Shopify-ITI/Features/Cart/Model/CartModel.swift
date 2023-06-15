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
            CartModel(cartRemoteService: resolver.require(CartRemoteService.self)
                      ,checker: resolver.require ((any AnyCartChecker).self))
        }
    }
    
    
    let cartRemoteService:CartRemoteService
    let checker:AnyCartChecker
    
    func getCart(with id: String) async -> Result<Cart, Error> {
        return cartHandler(result:await cartRemoteService.fetch(byId: id))
    }
    
    func changeItemQuantity(forCart id: String,forLine lineId:String,with quantity:Int ) async -> Result<Cart, Error> {
        if(quantity > 0){
            return cartHandler (result: await cartRemoteService.upDateLineFor(card: id,
                                                         with: ShopifyAPI.CartLineUpdateInput(id: lineId,quantity: .init(nullable: quantity))))
        }
        return   await deleteCartItem(forCart: id, forLine: lineId)
    }
    func deleteCartItem(forCart id: String,forLine lineId:String) async -> Result<Cart, Error> {
        return cartHandler(result:await cartRemoteService.removeLine(withLineID: lineId, forCart: id))
    }
    private func cartHandler(result:Result<Cart?, Error>)-> Result<Cart, Error>{
        switch result{
        case .success(let cart):
            print(cart?.cartLine.first?.id)

            if let cart = cart{
                return Result.success(cart)
            }else{
                return Result.failure(LocalErrors.NotFound)
            }
        case .failure(let error):
            print(error)

            return Result.failure(error)


        }
    }
}
