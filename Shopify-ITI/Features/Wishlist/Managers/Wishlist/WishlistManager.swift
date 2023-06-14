//
//  WishlistManager.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Combine

class WishlistManager : AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: WishlistManager.self) { resolver in
            WishlistManager(wishlistIdStore: resolver.require((any AnyWishlistIdLocalStore).self),
                            notificationCenter: resolver.require((any AnyNotificationCenter).self),
                            wishlistService: resolver.require(WishlistRemoteService.self),
                            authManager: resolver.require(AuthenticationManager.self))
        }
    }
    
    typealias State = Resource<Wishlist>
    
    private let wishlistIdStore: any AnyWishlistIdLocalStore
    private let notificationCenter: any AnyNotificationCenter
    private let wishlistService: WishlistRemoteService
    private let authManager: AuthenticationManager
    
    private var task: Task<Any, Error>? = nil
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var state: State = .loading
    
    init(wishlistIdStore: some AnyWishlistIdLocalStore,
         notificationCenter: some AnyNotificationCenter,
         wishlistService: WishlistRemoteService,
         authManager: AuthenticationManager) {
        self.wishlistIdStore = wishlistIdStore
        self.notificationCenter = notificationCenter
        self.wishlistService = wishlistService
        self.authManager = authManager
        
        self.initialize()
    }
    
    private func initialize() {
        authManager.$state
            .prepend(authManager.state)
            .receive(on: DispatchQueue.global()).sink { authState in
                print(authState)
                self.handleAuthState(authState)
            }.store(in: &cancellables)
    }
    
    private func handleAuthState(_ authState: AuthenticationState) {
        task?.cancel()
        task = Task {
            await handleAuthStateImpl(authState, self.state.data)
        }
    }
    
    private func handleAuthStateImpl(_ authState: AuthenticationState,
                                     _ wishlist: Wishlist?) async {
        await MainActor.run {
            self.state = .loading
        }
        let user = authState.user
        
        // no list, no user
        if wishlist == nil, user == nil {
            await removeList()
            // another user  owned list
        } else if let ownerId = wishlist?.customerId {
            if ownerId != user?.id {
                await removeList()
            }
            // guest owned list
        } else if let wishlist = wishlist,
                  let user = user {
            await updateOwnership(wishlist, user)
        } else if let wishlist = wishlist {
            await MainActor.run {
                self.state = .data(data: wishlist)
            }
        } else if let _ = user {
            await fetchList()
        } else  {
            await MainActor.run {
                self.state = .none
            }
        }
    }
    
    private func removeList() async {
        wishlistIdStore.delete()
        await MainActor.run {
            self.state = .none
        }
    }
    
    private func fetchList() async {
        if case .success(let savedListId) = wishlistIdStore.read() {
            let result = await wishlistService.fetch(by: savedListId)
            await handleWishlistResult(result)
        } else {
            let result = await wishlistService.fetch()
            await handleWishlistResult(result)
        }
        
    }
    
    private func updateOwnership(_ wishlist: Wishlist, _ user: User) async {
        let updatedWishlist = wishlist.copy(customerId: user.id)
        let result = await wishlistService.update(list: updatedWishlist)
        await handleWishlistResult(result)
    }
    
    private func handleWishlistResult(_ result: Result<Wishlist, ShopifyErrors<Any>>) async {
        guard !Task.isCancelled else { return }
        
        await MainActor.run {
            switch result {
                case .success(let newWishlist):
                    self.state = .data(data: newWishlist)
                    if newWishlist.customerId == nil {
                        _ = wishlistIdStore.write(id: newWishlist.id)
                    }
                    break
                case .failure(ShopifyErrors.NotFound):
                    self.state = .none
                    break
                case .failure(let error):
                    self.state = .error(error: error)
                    break
            }
        }
    }
    
    func addItem(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        if case .loading = state {
            _ = await task?.result
        }
        if case .data(let data) = state {
            let result = await addToList(data, item)
            if case .success(_) = result {
                notificationCenter.post(WishlistAddedEntryNotification(wishlist: data,
                                                                       entry: item))
            }
            return result
        }
        return await fetchOrCreate(item)
    }
    
    func removeItem(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        if case .loading = state {
            _ = await task?.result
        }
        if case .data(let data) = state {
            let result = await removeFromList(data, item)
            if case .success(_) = result {
                notificationCenter.post(WishlistRemovedEntryNotification(wishlist: data,
                                                                         entry: item))
            }
            return result
        }
        return .failure(.NotFound)
    }
    
    private func removeFromList(_ list: Wishlist, _ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        var items = list.entries
        items.removeValue(forKey: item.productId)
        let updatedList = list.copy(entries: items)
        let listResult = await wishlistService.update(list: updatedList)
        return await handleUpdatedListResult(listResult)
    }
    
    private func addToList(_ list: Wishlist, _ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        var items = list.entries
        items[item.productId] = item.variantId
        let updatedList = list.copy(entries: items)
        let listResult = await wishlistService.update(list: updatedList)
        return await handleUpdatedListResult(listResult)
    }
    
    private func fetchOrCreate(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        let listResult = await wishlistService.create(with: item)
        return await handleUpdatedListResult(listResult)
    }
    
    private func handleUpdatedListResult(_ listResult: Result<Wishlist, ShopifyErrors<Any>>) async -> Result<Void, ShopifyErrors<Any>> {
        guard !Task.isCancelled else { return .failure(.Unknown) }
        
        await MainActor.run {
            if case .success(let list) = listResult {
                let ownerId = list.customerId
                let userId = authManager.state.user?.id
                if userId == ownerId {
                    state = .data(data: list)
                }
                if userId == nil {
                    _ = wishlistIdStore.write(id: list.id)
                }
            }
        }
        return listResult.map { _ in }
    }
}
