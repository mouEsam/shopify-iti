//
//  CartManager.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct CartManager:AnyCartManager{
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCartManager).self) { resolver in
            CartManager(cartRemoteService: resolver.require(CartRemoteService.self),
                        checker: resolver.require(CartChecker.self),
                        userProvider:resolver.require(UserHolder.self)
            )
        }
    }
    
    let cartRemoteService:CartRemoteService
    let checker:AnyCartChecker
    let userProvider:AnyUserProvider
    
    func createOrUpdateCart(withVariant id:String,quantity :Int)async->Result<Cart?, Error>{
        if let cartID = checker.getCartID(for: userProvider.user?.id){
            return  await updateCart(with: id, quantity: quantity, inCart: cartID)
        }else{
            return await  creatCart(with: id, quantity: quantity)
        }
    }
    private func creatCart(with id:String,quantity :Int)async->Result<Cart?, Error>{
        let user = userProvider.user
        let buyerIdentity = ShopifyAPI.CartBuyerIdentityInput(email: .init(nullable: user?.email),phone: .init(nullable: user?.phone),customerAccessToken: .init(nullable: user?.id),deliveryAddressPreferences: .init(nullable: nil))
        let line = ShopifyAPI.CartLineInput(quantity:.init(nullable: quantity) ,merchandiseId: id)
        let result = await cartRemoteService.createCart(with: ShopifyAPI.CartInput(lines:[line],buyerIdentity:.init(nullable: buyerIdentity)))
        if case .success(let value) = result {
            if let cardId = value?.id{
                checker.set(cardID: cardId, with: id)
            }
        }
        return result
    }
    private func cartHandler(result:Result<Cart?, Error>)-> Result<Cart, Error>{
        switch result{
        case .success(let cart):
            if let cart = cart{
                return Result.success(cart)
            }else{
                return Result.failure(LocalErrors.NotFound)
            }
        case .failure(let error):
            return Result.failure(error)

        }
    }
    private func updateCart(with id:String,quantity :Int,inCart cardID:String)async->Result<Cart?, Error>{
        let line = ShopifyAPI.CartLineInput(quantity:.init(nullable: quantity) ,merchandiseId: id)
        return await cartRemoteService.upDate(card: cardID, with: line)
    }
}
