//
//  lineItems.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation

struct LineItem: Identifiable {
    var id: String
    
    let currentQuantity: Int
    let originalTotalPrice: Price
    let variant: OrderProductVariant
    

}

protocol LineItemConvertible  {
    associatedtype OrderProductVariant: OrderProductVariantConvertible
    associatedtype Price: PriceConvertible
    
    var currentQuantity: Int {get}
    var title: String {get}
    var originalTotalPrice: Price {get}
    var variant: OrderProductVariant {get}
    
}
extension LineItem {
 
    init(from lineItem : some LineItemConvertible){
        self.init(id: lineItem.title, currentQuantity: lineItem.currentQuantity, originalTotalPrice: Price(from: lineItem.originalTotalPrice), variant: OrderProductVariant(from: lineItem.variant))
    }
}
