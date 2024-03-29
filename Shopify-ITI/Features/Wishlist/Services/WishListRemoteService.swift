//
//  WishListRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 13/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK

protocol AnyWishlistRemoteService {
    typealias WishlistError = ShopifyErrors<Any>
    
    func fetch() async -> Result<Wishlist, WishlistError>
    
    func fetch(by wishlistId: String) async -> Result<Wishlist, WishlistError>

    func create(with entry: WishListEntry) async -> Result<Wishlist, WishlistError>
    
    func delete(wishlist: Wishlist) async -> Result<Void, WishlistError>
    
    func update(list wishList: Wishlist) async -> Result<Wishlist, WishlistError>
    
    func fetchItems(for wishListId: String,
                    count: Int,
                    with paginationInfo: PageInfo?) async -> Result<PageResult<WishlistItem>, WishlistError>
}

struct WishlistRemoteService: AnyInjectable, AnyWishlistRemoteService {
    static func register(_ container: AppContainer) {
        container.register(type: WishlistRemoteService.self) { resolver in
            WishlistRemoteService(remoteClient: resolver.require((any GraphQLClient).self,
                                                                 name: AdminEnvironmentProvider.diName),
                                localeProvider: resolver.require((any AnyLocaleProvider).self),
                                  userProvider: resolver.require((any AnyUserProvider).self))
        }.implements(AnyWishlistRemoteService.self)
    }
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    private let userProvider: any AnyUserProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider,
         userProvider: some AnyUserProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
        self.userProvider = userProvider
    }
    
    func fetch() async -> Result<Wishlist, WishlistError> {
        guard let user = userProvider.user,
              let userId = URL(string: user.id) else { return .failure(WishlistError.Unautherized) }
        let id = userId.lastPathComponent
        let query = ShopifyAdminAPI.GetWishlistQuery(query: "customer_id:\(id)")
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrders {
                if let wishlist = data.nodes.first {
                    return .success(Wishlist(from: wishlist))
                } else {
                    return .failure(WishlistError.NotFound)
                }
            } else {
                return .failure(WishlistError.init(from: result.errors ?? []))
            }
        }
    }
    
    func fetch(by wishlistId: String) async -> Result<Wishlist, WishlistError> {
        let query = ShopifyAdminAPI.GetWishlistByIdQuery(id: wishlistId)
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let wishlist = result.data?.draftOrder {
                return .success(Wishlist(from: wishlist))
            } else {
                return .failure(WishlistError.NotFound)
            }
        }
    }

    func create(with entry: WishListEntry) async -> Result<Wishlist, WishlistError> {
        let customerId = userProvider.user?.id
        
        let input = ShopifyAdminAPI.DraftOrderInput(lineItems: .init(arrayLiteral: .init(quantity: 1,
                                                                                         variantId: .some(entry.variantId))),
                                                    metafields: .init(arrayLiteral: .init(namespace: .some("customer_namespace"),
                                                                                          key: .some("lines_count"),
                                                                                          value: .some("1"))),
                                                    purchasingEntity: .init(nullable: customerId.map { .init(customerId: .some($0)) }))
        let mutation = ShopifyAdminAPI.CreateWishlistMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderCreate {
                if let wishlist = data.draftOrder {
                    return .success(Wishlist(from: wishlist))
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(WishlistError.Generic(errors: errors))
                }
            } else {
                return .failure(WishlistError.init(from: result.errors ?? []))
            }
        }
    }
    
    func delete(wishlist: Wishlist) async -> Result<Void, WishlistError> {
        let input = ShopifyAdminAPI.DraftOrderDeleteInput(id: wishlist.id)
        let mutation = ShopifyAdminAPI.DeleteWishlistMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderDelete {
                if let _ = data.deletedId {
                    return .success(Void())
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(WishlistError.Generic(errors: errors))
                }
            } else {
                return .failure(WishlistError.init(from: result.errors ?? []))
            }
        }
    }
    
    func update(list wishList: Wishlist) async -> Result<Wishlist, WishlistError> {
        let customerId = wishList.customerId
        let items = wishList.entries.map { ShopifyAdminAPI.DraftOrderLineItemInput(quantity: 1, variantId: .some($0.value)) }
        let input = ShopifyAdminAPI.DraftOrderInput(lineItems: .some(items),
                                                    metafields: .init(arrayLiteral: .init(namespace: .some("customer_namespace"),
                                                                                          key: .some("lines_count"),
                                                                                          value: .some("\(wishList.entries.count)"))),
                                                    tags: .some(wishList.tags),
                                                    purchasingEntity: .init(nullable: customerId.map { .init(customerId: .some($0)) }))
        let mutation = ShopifyAdminAPI.CreateWishlistMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderCreate {
                if let wishlist = data.draftOrder {
                    return .success(Wishlist(from: wishlist))
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(WishlistError.Generic(errors: errors))
                }
            } else {
                return .failure(WishlistError.init(from: result.errors ?? []))
            }
        }
    }
    
    func fetchItems(for wishListId: String,
                    count: Int,
                    with paginationInfo: PageInfo? = nil) async -> Result<PageResult<WishlistItem>, WishlistError> {
        let query = ShopifyAdminAPI.GetWishlistItemsQuery(cursor: .init(nullable: paginationInfo?.nextCursor),
                                                          count: count,
                                                          wishlistId: wishListId,
                                                          context: .init(country: .init(nullable: localeProvider.shopifyAdminCountry)))
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrder {
                let lines = data.lineItems.edges
                let pageInfo = data.lineItems.pageInfo
                return .success(.init(list: lines.map { WishlistItem(from: $0.node) },
                                      pageInfo: .init(nextCursor: pageInfo.endCursor,
                                                      hasNextCursor: pageInfo.hasNextPage)))
            } else {
                return .failure(WishlistError.NotFound)
            }
        }
    }
}
