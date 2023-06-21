//
//  OrderProductVariant.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation

struct OrderProductVariant: Identifiable {
    var id: String
    var image: RemoteImage
    let product: OrderProduct
}

protocol OrderProductVariantConvertible: Identifiable {
    associatedtype OrderProduct: OrderProductConvertible
    associatedtype RemoteImage: 
    
    var id: String {get}
    var product: OrderProduct {get}
    var image: RemoteImage {get}
    
}
extension OrderProductVariant {
 
    init(from orderProductVariant : some OrderProductVariantConvertible){
        self.init(id: orderProductVariant.id, image:RemoteImage(from: orderProductVariant.image), product: OrderProduct(from: orderProductVariant.product))
    }
}
