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
    let userToken:String?

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
        userToken = cart.buyerIdentity.customer?.id
        self.cartLine = tempLine
        totalAmount = Double(cart.cost.totalAmount.amount) ?? 0
    }
   
}
extension Cart{
    init(from cart: ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart){
        var tempLine:[CartLine] = []
        id = cart.id
        userToken = cart.buyerIdentity.customer?.id

        for cardline in cart.lines.edges{
            tempLine.append( .init(from: cardline.node))
        }
        self.cartLine = tempLine
        totalAmount = Double(cart.cost.totalAmount.amount) ?? 0

    }
}
extension Cart{
    init(from cart: ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart){
        var tempLine:[CartLine] = []
        id = cart.id
        userToken = cart.buyerIdentity.customer?.id

        for cardline in cart.lines.edges{
            tempLine.append( .init(from: cardline.node))
        }
        self.cartLine = tempLine
        totalAmount = Double(cart.cost.totalAmount.amount) ?? 0

    }
}
extension Cart{
    init(from cart: ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart){
        var tempLine:[CartLine] = []
        id = cart.id
        userToken = cart.buyerIdentity.customer?.id

        for cardline in cart.lines.edges{
            tempLine.append( .init(from: cardline.node))
        }
        self.cartLine = tempLine
        totalAmount = Double(cart.cost.totalAmount.amount) ?? 0

    }
}
extension Cart{
    init(from cart: ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart){
        var tempLine:[CartLine] = []
        id = cart.id
        userToken = cart.buyerIdentity.customer?.id
        for cardline in cart.lines.edges{
            tempLine.append( .init(from: cardline.node))
        }
        self.cartLine = tempLine
        totalAmount = Double(cart.cost.totalAmount.amount) ?? 0

    }
}
extension Cart{
    init(from cart: ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart){
        var tempLine:[CartLine] = []
        id = cart.id
        userToken = cart.buyerIdentity.customer?.id
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
extension ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
extension ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
extension ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
extension ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
extension ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
