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
    let featuredImage: RemoteImage?

    let productType : String
}

protocol ProductTypeConvertible: Identifiable {
    associatedtype FeaturedImage: RemoteImageConvertible
    var id: String { get }
    var featuredImage: FeaturedImage? { get }

    var productType: String { get }
}

extension ProductType {
    init(from node: some ProductTypeConvertible){
        self.init(id: node.id, featuredImage: node.featuredImage.map { RemoteImage(from: $0) } , productType: node.productType)
    }
}

extension ShopifyAPI.GetCollectionQuery.Data.Collection.Products.Node : ProductTypeConvertible {
}

extension ShopifyAPI.GetCollectionQuery.Data.Collection.Products.Node.FeaturedImage: RemoteImageConvertible {}



