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
    var totalPrice: Price {get}
    var lineItems: [LineItem] {get}
    
}
extension Order {
    init(from order: some OrderConvertible) {
        self.init(id: order.orderNumber, totalPrice: order.totalPrice, lineItems: order.lineItems.map{LineItem(from: $0)})
       
    }
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node : OrderConvertible {

    
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems : LineItemConvertible {
    
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant :  OrderProductVariantConvertible{
    
    
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.OriginalTotalPrice : PriceConvertible {
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.image : RemoteImageConvertible{
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product : ProductConvertible{
    
    public var id: ObjectIdentifier {
        <#code#>
    }
    
 
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange : PriceConvertible{
    
}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.FeaturedImage : RemoteImageConvertible{
    
}


