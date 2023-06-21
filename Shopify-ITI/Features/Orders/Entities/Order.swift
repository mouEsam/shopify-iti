//
//  Order.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct Order: Identifiable {
    let id : Int
    let totalPrice: Price
    let lineItems: [LineItem]
}

protocol OrderConvertible {
    associatedtype TotalPrice: PriceConvertible
    associatedtype LineItem: LineItemConvertible
    
    var orderNumber: Int { get }
    var totalPrice: TotalPrice {get}
    var items: [LineItem] {get}
}

extension Order {
    init(from order: some OrderConvertible) {
        self.init(id: order.orderNumber,
                  totalPrice: Price(from: order.totalPrice),
                  lineItems: order.items.map { LineItem(from: $0) }
        )
    }
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node : OrderConvertible {
    var items: [some LineItemConvertible] { lineItems.edges.map(\.node) }
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.TotalPrice : PriceConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node: LineItemConvertible {
    var product: some ProductConvertible { variant!.product }
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.OriginalTotalPrice : PriceConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product : ProductConvertible {
    var variantId: String { variants.nodes.first!.id }
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange :  PriceRangeConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange.MaxVariantPrice :  PriceConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange.MinVariantPrice :  PriceConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.FeaturedImage :  RemoteImageConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant :  ProductVariantConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Image :  RemoteImageConvertible{
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Price :  PriceConvertible {
}
