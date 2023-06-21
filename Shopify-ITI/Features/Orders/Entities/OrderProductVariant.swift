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
    associatedtype variant: ProductConvertible
    associatedtype image: RemoteImageConvertible
    
    var id: String {get}
    var product: Product {get}
    var image: RemoteImage {get}
    
}
extension OrderProductVariant {
 
    init(from orderProductVariant : some OrderProductVariantConvertible){
        self.init(id: orderProductVariant.id, image: orderProductVariant.image, product: orderProductVariant.product)
    }
}

struct OrderProduct  {
    var title: RemoteImage
    let vendor: String
}

protocol OrderProductConvertible: Identifiable {
    associatedtype variant: ProductConvertible
    associatedtype image: RemoteImageConvertible
    
    var id: String {get}
    var product: Product {get}
    var image: RemoteImage {get}
    
}
extension OrderProductVariant {
 
    init(from orderProductVariant : some OrderProductVariantConvertible){
        self.init(id: orderProductVariant.id, image: orderProductVariant.image, product: orderProductVariant.product)
    }
}
