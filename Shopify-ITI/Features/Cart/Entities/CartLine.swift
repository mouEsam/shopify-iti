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
    let product:Product
}

extension ShopifyAPI.CartInfo.Lines.Edge.Node.Cost.TotalAmount: PriceConvertible {}

extension CartLine{
    init(from cartLine: ShopifyAPI.CartInfo.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = .init(from: cartLine.cost.totalAmount)
        product = .init(from: cartLine.merchandise.asProductVariant!.product)
    }
}
