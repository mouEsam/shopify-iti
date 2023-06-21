//
//  CartLine.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct CartLine: Identifiable {
    let id: String
    let quantity: Int
    let productVariant:ProductVariant
    let totalAmount: Price
}

extension ShopifyAPI.GetCartQuery.Data.Cart.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}
extension ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}
extension ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}
extension ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}
extension ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}
extension ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}

extension CartLine{
    init(from cartLine: ShopifyAPI.GetCartQuery.Data.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
    }
}

extension CartLine{
    init(from cartLine: ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
    }
}

extension CartLine{
    init(from cartLine: ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
    }
}

extension CartLine{
    init(from cartLine: ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
    }
}

extension CartLine{
    init(from cartLine: ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
    }
}

extension CartLine{
    init(from cartLine: ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
    }
}
