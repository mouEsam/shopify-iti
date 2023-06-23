//
//  OrdersString.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation

protocol AnyOrdersStrings {
    var orderNumber: String { get }
    var totalPrice: String { get }
    var quantityItem: String { get }
    var emptyList: String { get }
  
}
// TODO: localize
struct OrdersStrings: AnyOrdersStrings, AnyInjectable  {
    
  
    
    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyOrdersStrings).self) { resolver in
            OrdersStrings()
        }
    }
   
    let orderNumber: String  = "OrdersStrings.orderNumber"
    let emptyList: String =  "OrdersStrings.emptyList"
    let totalPrice: String = "OrdersStrings.totalPrice"
    let quantityItem: String = "OrdersStrings.quantityItem"

    
}
