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
    var lineItems: [LineItem] {get}
    
}
extension Order {
    init(from order: some OrderConvertible) {
        self.init(id: order.orderNumber, totalPrice: Price(from: order.totalPrice), lineItems: order.lineItems.map{LineItem(from: $0)})
       
    }
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node : OrderConvertible {
    
    


}
extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.TotalPrice : PriceConvertible {
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node: LineItemConvertible {
   
    
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.OriginalTotalPrice : PriceConvertible {
}



extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product : OrderProductConvertible{
    
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant :  OrderProductVariantConvertible {
 
    
 
    
    
}

extension ShopifyAPI.GetOrdersQuery.Data.Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Image :  RemoteImageConvertible{
    
    
    
}


