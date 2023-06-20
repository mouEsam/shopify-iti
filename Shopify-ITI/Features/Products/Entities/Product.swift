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
    let vendor: String
    let description: String
    let featuredImage: RemoteImage?
    let priceRange: PriceRange
    let variantId: String
}

protocol ProductConvertible: Identifiable {
    associatedtype FeaturedImage: RemoteImageConvertible
    associatedtype PriceRange: PriceRangeConvertible
    
    var id: String { get }
    var handle: String { get }
    var title: String { get }
    var vendor: String { get }
    var description: String { get }
    var featuredImage: FeaturedImage? { get }
    var priceRange: PriceRange { get }
    var variantId: String { get }
}

extension Product {
    init(from product: some ProductConvertible) {
        self.init(id : product.id,
                  handle : product.handle,
                  title : product.title,
                  vendor : product.vendor,
                  description : product.description,
                  featuredImage : product.featuredImage.map { RemoteImage(from: $0) },
                  priceRange : PriceRange(from: product.priceRange),
                  variantId: product.variantId)
    }
}

extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node: ProductConvertible {
    var variantId: String { variants.nodes.first!.id }
}

extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.FeaturedImage: RemoteImageConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.PriceRange: PriceRangeConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.PriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductsByQuery.Data.Products.Edge.Node.PriceRange.MinVariantPrice: PriceConvertible {}

extension ShopifyAPI.GetProductsByCollectionQuery.Data.Collection.Products.Edge.Node: ProductConvertible {
    var variantId: String { variants.nodes.first!.id }
}
extension ShopifyAPI.GetProductsByCollectionQuery.Data.Collection.Products.Edge.Node.FeaturedImage: RemoteImageConvertible {}
extension ShopifyAPI.GetProductsByCollectionQuery.Data.Collection.Products.Edge.Node.PriceRange: PriceRangeConvertible {}
extension ShopifyAPI.GetProductsByCollectionQuery.Data.Collection.Products.Edge.Node.PriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductsByCollectionQuery.Data.Collection.Products.Edge.Node.PriceRange.MinVariantPrice: PriceConvertible {}


extension ShopifyAPI.SearchProductsQuery.Data.Search.Edge.Node.AsProduct: ProductConvertible {
    var variantId: String { variants.nodes.first!.id }
}
extension ShopifyAPI.SearchProductsQuery.Data.Search.Edge.Node.AsProduct.FeaturedImage: RemoteImageConvertible {}
extension ShopifyAPI.SearchProductsQuery.Data.Search.Edge.Node.AsProduct.PriceRange: PriceRangeConvertible {}
extension ShopifyAPI.SearchProductsQuery.Data.Search.Edge.Node.AsProduct.PriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAPI.SearchProductsQuery.Data.Search.Edge.Node.AsProduct.PriceRange.MinVariantPrice: PriceConvertible {}


