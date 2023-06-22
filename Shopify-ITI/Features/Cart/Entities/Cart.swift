//
//  Cart.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct Cart:Identifiable{
    let id: String
    let userId: String?
    let cartLine: [CartLine]
    let subtotalAmount: Price
    let totalAmount: Price
    let totalTaxAmount: Price?
}

extension Cart{
    init(from cart: ShopifyAPI.GetCartQuery.Data.Cart){
        id = cart.id
        self.userId = cart.buyerIdentity.customer?.id
        self.cartLine = cart.lines.edges.map(\.node).map { .init(from: $0) }
        self.subtotalAmount = .init(from: cart.cost.subtotalAmount)
        self.totalAmount = .init(from: cart.cost.totalAmount)
        self.totalTaxAmount = cart.cost.totalTaxAmount.map { .init(from: $0) }
    }
}

extension Cart{
    init(from cart: ShopifyAPI.CreateCartMutation.Data.CartCreate.Cart){
        id = cart.id
        self.userId = cart.buyerIdentity.customer?.id
        self.cartLine = cart.lines.edges.map(\.node).map { .init(from: $0) }
        self.subtotalAmount = .init(from: cart.cost.subtotalAmount)
        self.totalAmount = .init(from: cart.cost.totalAmount)
        self.totalTaxAmount = cart.cost.totalTaxAmount.map { .init(from: $0) }
    }
}

extension Cart{
    init(from cart: ShopifyAPI.AddCartLinesMutation.Data.CartLinesAdd.Cart){
        id = cart.id
        self.userId = cart.buyerIdentity.customer?.id
        self.cartLine = cart.lines.edges.map(\.node).map { .init(from: $0) }
        self.subtotalAmount = .init(from: cart.cost.subtotalAmount)
        self.totalAmount = .init(from: cart.cost.totalAmount)
        self.totalTaxAmount = cart.cost.totalTaxAmount.map { .init(from: $0) }
    }
}

extension Cart{
    init(from cart: ShopifyAPI.UpdateCartLinesMutation.Data.CartLinesUpdate.Cart){
        id = cart.id
        self.userId = cart.buyerIdentity.customer?.id
        self.cartLine = cart.lines.edges.map(\.node).map { .init(from: $0) }
        self.subtotalAmount = .init(from: cart.cost.subtotalAmount)
        self.totalAmount = .init(from: cart.cost.totalAmount)
        self.totalTaxAmount = cart.cost.totalTaxAmount.map { .init(from: $0) }
    }
}

extension Cart{
    init(from cart: ShopifyAPI.RemoveCartLinesMutation.Data.CartLinesRemove.Cart){
        id = cart.id
        self.userId = cart.buyerIdentity.customer?.id
        self.cartLine = cart.lines.edges.map(\.node).map { .init(from: $0) }
        self.subtotalAmount = .init(from: cart.cost.subtotalAmount)
        self.totalAmount = .init(from: cart.cost.totalAmount)
        self.totalTaxAmount = cart.cost.totalTaxAmount.map { .init(from: $0) }
    }
}

extension Cart{
    init(from cart: ShopifyAPI.UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart){
        id = cart.id
        self.userId = cart.buyerIdentity.customer?.id
        self.cartLine = cart.lines.edges.map(\.node).map { .init(from: $0) }
        self.subtotalAmount = .init(from: cart.cost.subtotalAmount)
        self.totalAmount = .init(from: cart.cost.totalAmount)
        self.totalTaxAmount = cart.cost.totalTaxAmount.map { .init(from: $0) }
    }
}

extension ShopifyAPI.CartInfo.Cost.TotalAmount: PriceConvertible {}
extension ShopifyAPI.CartInfo.Cost.SubtotalAmount: PriceConvertible {}
extension ShopifyAPI.CartInfo.Cost.TotalTaxAmount: PriceConvertible {}

extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant: ProductVariantConvertible {}
extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Image: RemoteImageConvertible {}
extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Price: PriceConvertible {}
extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Product: ProductConvertible {
    var variantId: String {variants.nodes.first!.id}
    
}
extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Product.FeaturedImage: RemoteImageConvertible {}

extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Product.PriceRange:PriceRangeConvertible  {}

extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Product.PriceRange.MaxVariantPrice:PriceConvertible  {}
extension ShopifyAPI.CartInfo.Lines.Edge.Node.Merchandise.AsProductVariant.Product.PriceRange.MinVariantPrice:PriceConvertible  {}
