//
//  WishListItem.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 13/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import Shopify_Admin_ITI_SDK

struct WishlistItem: Identifiable {
    let id: String
    let name: String
    let vendor: String?
    let image: RemoteImage?
    let total: Price
    let product: Product
    let variant: ProductVariant
}

protocol WishlistItemConvertible {
    associatedtype RemoteImage: RemoteImageConvertible
    associatedtype Price: PriceConvertible
    associatedtype Product: ProductConvertible
    associatedtype ProductVariant: ProductVariantConvertible
    
    var id: String { get }
    var name: String { get }
    var vendor: String? { get }
    var image: RemoteImage? { get }
    var total: Price { get }
    var product: Product? { get }
    var variant: ProductVariant? { get }
}

extension WishlistItem {
    init(from item: some WishlistItemConvertible) {
        self.init(id: item.id,
                  name: item.name,
                  vendor: item.vendor,
                  image: item.image.map { RemoteImage(from: $0) },
                  total:  Price(from: item.total),
                  product: Product(from: item.product!),
                  variant: ProductVariant(from: item.variant!))
    }
}

extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node: WishlistItemConvertible {
    var total: some PriceConvertible { originalTotalSet.presentmentMoney }
}

extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Image: RemoteImageConvertible {}
extension ShopifyAdminAPI.WishListItemInfo.OriginalTotalSet.PresentmentMoney: PriceConvertible {}

extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Product: ProductConvertible {
    var variantId: String { variants.nodes.first!.id }
}
extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Product.FeaturedImage: RemoteImageConvertible {}
extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Product.PriceRange: PriceRangeConvertible {}
extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Product.PriceRange.MaxVariantPrice: PriceConvertible {}
extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Product.PriceRange.MinVariantPrice: PriceConvertible {}

extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Variant: ProductVariantConvertible {
    var price: some PriceConvertible { contextualPricing.price }
}

extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Variant.ContextualPricing.Price: PriceConvertible {}
extension ShopifyAdminAPI.GetWishlistItemsQuery.Data.DraftOrder.LineItems.Edge.Node.Variant.Image: RemoteImageConvertible {}
