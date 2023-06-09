//
//  DetailedProduct.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct DetailedProduct: Identifiable {
    let id: String
    let handle: String
    let title: String
    let description: String
    let featuredImage: RemoteImage?
    let availableForSale: Bool
    let compareAtPriceRange: PriceRange
    let metafields: [MetaField]
    let priceRange: PriceRange
    let tags: [String]
    let totalInventory: Int?
    let vendor: String
    let options: [ProductOption]
    let collections: [ProductCollection]
    let images: [RemoteImage]
    let variants: [ProductVariant]
}

extension DetailedProduct {
    init(from product: ShopifyAPI.GetProductByIdQuery.Data.Product) {
        self.init(id : product.id,
                  handle : product.id,
                  title : product.id,
                  description : product.id,
                  featuredImage : product.featuredImage.map { RemoteImage(from: $0) },
                  availableForSale : product.availableForSale,
                  compareAtPriceRange : PriceRange(from: product.compareAtPriceRange),
                  metafields : product.metafields.compactMap{$0}.map{ MetaField(from: $0) },
                  priceRange : PriceRange(from: product.priceRange),
                  tags : product.tags,
                  totalInventory : product.totalInventory,
                  vendor : product.vendor,
                  options : product.options.map { ProductOption(from: $0) },
                  collections : product.collections.nodes.map { ProductCollection(from: $0) },
                  images: product.images.nodes.map { RemoteImage(from: $0) },
                  variants : product.variants.nodes.map { ProductVariant(from: $0) })
    }
}

extension ShopifyAPI.GetProductByIdQuery.Data.Product.Metafield: MetaFieldConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Option: ProductOptionConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Collections.Node: ProductCollectionConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Variants.Node: ProductVariantConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Images.Node: RemoteImageConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.FeaturedImage: RemoteImageConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Collections.Node.Image: RemoteImageConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Variants.Node.Image: RemoteImageConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.PriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.PriceRange.MinVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.Variants.Node.Price: PriceConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.CompareAtPriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.CompareAtPriceRange.MinVariantPrice: PriceConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.PriceRange: PriceRangeConvertible {}
extension ShopifyAPI.GetProductByIdQuery.Data.Product.CompareAtPriceRange: PriceRangeConvertible {}
