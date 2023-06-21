//
//  OrderProduct.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation

struct OrderProduct  {
    var title: String
    let vendor: String
}

protocol OrderProductConvertible {


    var title: String {get}
    var vendor: String {get}
    
}
extension OrderProduct {
 
    init(from orderProduct : some OrderProductConvertible){
        self.init(title: orderProduct.title, vendor: orderProduct.vendor)
    }
}
