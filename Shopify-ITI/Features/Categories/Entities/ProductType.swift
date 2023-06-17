//
//  ProductType.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct ProductType : Identifiable{
    let id :String
    let productType : String
}

protocol ProductTypeConvertible: Identifiable {
    var id: String { get }
    var productType: String { get }
}

extension ProductType {
    init(from node: some ProductTypeConvertible){
        self.init(id: node.id, productType: node.productType)
    }
}

extension ShopifyAPI.GetCollectionQuery.Data.Collection.Products.Node : ProductTypeConvertible {}



