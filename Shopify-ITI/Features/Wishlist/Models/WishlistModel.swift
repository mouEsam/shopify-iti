//
//  WishlistModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

protocol AnyWishlistModel {
    func fetch(for wishListId: String,
               with paginationInfo: PageInfo?) async -> Result<SourcedData<PageResult<WishlistItem>>, ShopifyErrors<Any>>
}

struct WishlistModel: AnyWishlistModel, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyWishlistModel).self, scope: .transient) { resolver in
            WishlistModel(wishlistService: resolver.require(WishlistRemoteService.self),
                          configsProvider: resolver.require((any AnyConfigsProvider).self))
        }
    }
    
    private let wishlistService: WishlistRemoteService
    private let configsProvider: any AnyConfigsProvider
    
    init(wishlistService: WishlistRemoteService,
         configsProvider: some AnyConfigsProvider) {
        self.wishlistService = wishlistService
        self.configsProvider = configsProvider
    }
    
    func fetch(for wishListId: String,
               with paginationInfo: PageInfo? = nil) async -> Result<SourcedData<PageResult<WishlistItem>>, ShopifyErrors<Any>> {
        let result = await wishlistService.fetchItems(for: wishListId,
                                          count: configsProvider.wishlistItemsCountPerPage,
                                          with: paginationInfo)
        return result.map { .remote($0) }
    }
}
