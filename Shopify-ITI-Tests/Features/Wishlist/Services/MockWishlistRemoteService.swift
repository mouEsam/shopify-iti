//
//  MockWishlistRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockWishlistRemoteService: AnyWishlistRemoteService {

    var service: AnyWishlistRemoteService? = nil
    
    var fetchResult: Result<Wishlist, WishlistError>! = nil
    var fetchByIdResult: Result<Wishlist, WishlistError>! = nil
    var createResult: Result<Wishlist, WishlistError>! = nil
    var deleteResult: Result<Void, WishlistError>! = nil
    var updateResult: Result<Wishlist, WishlistError>! = nil
    var fetchItemsResult: Result<PageResult<WishlistItem>, WishlistError>! = nil
    
    func fetch() async -> Result<Wishlist, WishlistError> {
        if let service = service {
            return await service.fetch()
        } else {
            return fetchResult
        }
    }
    
    func fetch(by wishlistId: String) async -> Result<Wishlist, WishlistError> {
        if let service = service {
            return await service.fetch(by: wishlistId)
        } else {
            return fetchByIdResult
        }
    }
    
    func create(with entry: WishListEntry) async -> Result<Wishlist, WishlistError> {
        if let service = service {
            return await service.create(with: entry)
        } else {
            return createResult
        }
    }
    
    func delete(wishlist: Wishlist) async -> Result<Void, WishlistError> {
        if let service = service {
            return await service.delete(wishlist: wishlist)
        } else {
            return deleteResult
        }
    }
    
    func update(list wishList: Wishlist) async -> Result<Wishlist, WishlistError> {
        if let service = service {
            return await service.update(list: wishList)
        } else {
            return updateResult
        }
    }
    
    func fetchItems(for wishListId: String, count: Int, with paginationInfo: PageInfo?) async -> Result<PageResult<WishlistItem>, WishlistError> {
        if let service = service {
            return await service.fetchItems(for: wishListId, count: count, with: paginationInfo)
        } else {
            return fetchItemsResult
        }
    }
}
