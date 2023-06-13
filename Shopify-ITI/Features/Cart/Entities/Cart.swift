//
//  Cart.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct Cart:Identifiable{
    let id:String
    let cartLine:[CartLine]
    let totalAmount:Double
}
extension Cart{
    init(from cart: ShopifyAPI.GetCartQuery.Data.Cart){
        var tempLine:[CartLine] = []
        id = cart.id
        for cardline in cart.lines.edges{
            tempLine.append( .init(from: cardline.node))
        }
        self.cartLine = tempLine
        totalAmount = Double(cart.cost.totalAmount.amount) ?? 0
    }
}
extension ShopifyAPI.GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.GetCartQuery.Data.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
