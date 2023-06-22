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
                      ,cartIdStore: resolver.require ((any AnyCartIdStore).self))
        }
    }
    
    
    let cartRemoteService:CartRemoteService
    let cartIdStore:AnyCartIdStore
    
    func getCart() async -> Result<Cart, Error> {
        
        if cartIdStore.exists(){
            switch cartIdStore.read(){
            case .success(let cartID):
                return cartHandler(result:await cartRemoteService.fetch(byId: cartID))
            case .failure(let error):
                return .failure(error)
            }
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func changeItemQuantity( forLine lineId:String,with quantity:Int ) async -> Result<Cart, Error> {
        if(quantity > 0){
            
            switch cartIdStore.read(){
            case .success(let cartID):
                return cartHandler (result: await cartRemoteService.upDateLineFor(card: cartID,
                                                                                  with: ShopifyAPI.CartLineUpdateInput(id: lineId,quantity: .init(nullable: quantity))))
            case .failure(let error):
                return .failure(error)
            }
        }
        
        return   await deleteCartItem(forLine: lineId)
    }
    func deleteCartItem( forLine lineId:String) async -> Result<Cart, Error> {
        switch cartIdStore.read(){
        case .success(let cartID):
            return cartHandler(result:await cartRemoteService.removeLine(withLineID: lineId, forCart: cartID))
        case .failure(let error):
            return .failure(error)
            
        }
    }
    private func cartHandler(result:Result<Cart?, Error>)-> Result<Cart, Error>{
        switch result{
        case .success(let cart):

            if let cart = cart,!cart.cartLine.isEmpty{
                return Result.success(cart)
            }else{
                return Result.failure(LocalErrors.NotFound)
            }
        case .failure(let error):

            return Result.failure(error)


        }
    }
}
