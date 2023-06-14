//
//  Product.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct Product: Identifiable {
    let id: String
    let handle: String
    let title: String
    let description: String
    let featuredImage: RemoteImage?
    let priceRange: PriceRange
}

protocol ProductConvertible: Identifiable {
    associatedtype FeaturedImage: RemoteImageConvertible
    associatedtype PriceRange: PriceRangeConvertible
    
    var id: String { get }
    var handle: String { get }
    var title: String { get }
    var description: String { get }
    var featuredImage: FeaturedImage? { get }
    var priceRange: PriceRange { get }
}

extension Product {
    init(from product: some ProductConvertible) {
        self.init(id : product.id,
                  handle : product.id,
                  title : product.id,
                  description : product.id,
                  featuredImage : product.featuredImage.map { RemoteImage(from: $0) },
                  priceRange : PriceRange(from: product.priceRange))
    }
}

extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node: ProductConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.FeaturedImage: RemoteImageConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.PriceRange: PriceRangeConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.PriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.PriceRange.MinVariantPrice: PriceConvertible {}
