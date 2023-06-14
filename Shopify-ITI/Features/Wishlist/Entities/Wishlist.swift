//
//  WishList.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import Shopify_Admin_ITI_SDK

struct Wishlist: Identifiable, Changeable {
    let id: String
    let customerId: String?
    let tags: [String]
    let entries: [String: String]
    
    func copy(customerId: String? = nil,
              entries: [String: String]? = nil) -> Wishlist {
        return .init(id: id,
                     customerId: customerId ?? self.customerId,
                     tags: tags,
                     entries: entries ?? self.entries)
    }
}

protocol WishlistConvertible {
    associatedtype Entry: WishListEntryConvertible
    
    var id: String { get }
    var customerId: String? { get }
    var tags: [String] { get }
    var entries: [Entry] { get }
}

extension Wishlist {
    init(from list: some WishlistConvertible) {
        self.init(id: list.id,
                  customerId: list.customerId,
                  tags: list.tags,
                  entries: .init(list.entries.map { ($0.productId, $0.variantId) },
                                 uniquingKeysWith: { first, second in first }))
    }
}

protocol WishListEntryConvertible {
    var productId: String { get }
    var variantId: String { get }
}

struct WishListEntry {
    let productId: String
    let variantId: String
}

extension ShopifyAdminAPI.GetWishlistQuery.Data.DraftOrders.Node: WishlistConvertible {
    var customerId: String? { customer?.id }
    var entries: [some WishListEntryConvertible] { lineItems.nodes }
}

extension ShopifyAdminAPI.CreateWishlistMutation.Data.DraftOrderCreate.DraftOrder: WishlistConvertible {
    var customerId: String? { customer?.id }
    var entries: [some WishListEntryConvertible] { lineItems.nodes }
}

extension ShopifyAdminAPI.GetWishlistByIdQuery.Data.DraftOrder: WishlistConvertible {
    var customerId: String? { customer?.id }
    var entries: [some WishListEntryConvertible] { lineItems.nodes }
}

extension ShopifyAdminAPI.WishListInfo.LineItems.Node: WishListEntryConvertible {
    var productId: String { product!.id }
    var variantId: String { variant!.id }
}
