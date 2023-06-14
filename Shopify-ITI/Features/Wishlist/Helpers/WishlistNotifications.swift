//
//  WishlistNotifications.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

struct FetchedWishlistNotification: AppNotification {
    static let rawName: String = "FetchedWishlistNotification"
    
    let wishlist: Wishlist
}

struct WishlistAddedEntryNotification: AppNotification {
    static let rawName: String = "WishlistAddedEntryNotification"
    
    let wishlist: Wishlist
    let entry: WishListEntry
}

struct WishlistRemovedEntryNotification: AppNotification {
    static let rawName: String = "WishlistRemovedEntryNotification"
    
    let wishlist: Wishlist
    let entry: WishListEntry
}
