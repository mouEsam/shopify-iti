//
//  lineItems.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation

struct LineItem: Identifiable {
    let id: String
    let currentQuantity: Int
    let originalTotalPrice: Price
    let variant: ProductVariant
    let product: Product
}

protocol LineItemConvertible  {
    associatedtype Product: ProductConvertible
    associatedtype ProductVariant: ProductVariantConvertible
    associatedtype Price: PriceConvertible
    
    var currentQuantity: Int {get}
    var title: String {get}
    var originalTotalPrice: Price {get}
    var variant: ProductVariant? {get}
    var product: Product {get}
}

extension LineItem {
    init(from lineItem : some LineItemConvertible){
        self.init(id: lineItem.title,
                  currentQuantity: lineItem.currentQuantity,
                  originalTotalPrice: Price(from: lineItem.originalTotalPrice),
                  variant: ProductVariant(from: lineItem.variant!),
                  product: Product(from: lineItem.product)
        )
    }
}
