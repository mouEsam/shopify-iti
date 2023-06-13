//
//  CartLine.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct CartLine:Identifiable{
    let id: String
    let quantity: Int
    let productVariant:ProductVariant
    let totalAmount:Double
}
extension CartLine{
    init(from cartLine: ShopifyAPI.GetCartQuery.Data.Cart.Lines.Edge.Node){
        id = cartLine.id
        quantity = cartLine.quantity
        productVariant = .init(from:  cartLine.merchandise.asProductVariant!)
        totalAmount = Double(cartLine.cost.totalAmount.amount) ?? 0
    }
}
