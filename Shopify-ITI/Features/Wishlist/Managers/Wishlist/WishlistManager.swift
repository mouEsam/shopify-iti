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
        print("ADSADASDASDADASD")
    }
    
    private func initialize() {
        authManager.$state
            .prepend(authManager.state)
            .receive(on: DispatchQueue.global()).sink { authState in
                self.handleAuthState(authState)
            }.store(in: &cancellables)
    }
    
    private func evaluateState() {
        handleAuthState(authManager.state)
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
        
        if let user = authState.user {
            if let wishlist = wishlist {
                if wishlist.customerId == nil {
                    await updateOwnership(wishlist, user)
                } else if wishlist.customerId != user.id {
                    await removeAndFetchList()
                } else {
                    await setList(wishlist)
                }
            } else {
                await fetchList()
            }
        } else {
            if let wishlist = wishlist {
                if let _ = wishlist.customerId {
                    await removeList()
                } else {
                    await setList(wishlist)
                }
            } else {
                await fetchList()
            }
        }
    }
    
    private func setList(_ wishlist: Wishlist) async {
        await MainActor.run {
            self.state = .data(data: wishlist)
        }
    }
    
    private func removeList() async {
        wishlistIdStore.delete()
        await MainActor.run {
            self.state = .none
        }
    }
    
    private func removeAndFetchList() async {
        wishlistIdStore.delete()
        await fetchList()
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
        let existingWishlistResult = await wishlistService.fetch()
        if case .success(let existingWishlist) = existingWishlistResult {
            var entries = existingWishlist.entries
            entries.merge(wishlist.entries) { first, __ in first }
            let existingWishlist = existingWishlist.copy(entries: entries)
            let listResult = await wishlistService.update(list: existingWishlist)
            if case .success(_) = listResult {
                Task {
                    await wishlistService.delete(wishlist: wishlist)
                }
            }
            return await handleWishlistResult(listResult)
        } else if case .failure(let error) = existingWishlistResult {
            switch error {
                case .NotFound:
                    return await self.updateOwnershipImpl(wishlist, user)
                default:
                    return await handleWishlistResult(existingWishlistResult,
                                                      withFallback: wishlist)
            }
        } else {
            return await self.updateOwnershipImpl(wishlist, user)
        }
    }
    
    private func updateOwnershipImpl(_ wishlist: Wishlist, _ user: User) async {
        let updatedWishlist = wishlist.copy(customerId: user.id)
        let result = await wishlistService.update(list: updatedWishlist)
        await handleWishlistResult(result)
    }
    
    private func handleWishlistResult(_ result: Result<Wishlist, ShopifyErrors<Any>>,
                                      withFallback: Wishlist? = nil) async {
        guard !Task.isCancelled else { return }
        
        await MainActor.run {
            switch result {
                case .success(let newWishlist):
                    self.handleWishlist(newWishlist)
                    break
                case .failure(ShopifyErrors.Unautherized):
                    fallthrough
                case .failure(ShopifyErrors.NotFound):
                    self.handleWishlist(withFallback)
                    break
                case .failure(let error):
                    self.state = .error(error: error)
                    break
            }
        }
    }
    
    func toggleItem(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        if case .loading = state {
            _ = await task?.result
        }
        if case .data(let data) = state {
            if let _ = data.entries[item.productId] {
                return await removeItem(item)
            } else {
                return await addItem(item)
            }
        } else if case .none = state {
            return await addItem(item)
        }
        return .failure(.Unknown)
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
        if updatedList.entries.isEmpty {
            let listResult = await wishlistService.delete(wishlist: updatedList)
            return await handleDeletedListResult(listResult)
        } else {
            let listResult = await wishlistService.update(list: updatedList)
            return await handleUpdatedListResult(listResult)
        }
    }
    
    private func handleDeletedListResult(_ listResult: Result<Void, ShopifyErrors<Any>>) async -> Result<Void, ShopifyErrors<Any>> {
        guard !Task.isCancelled else { return .failure(.Unknown) }
        
        await MainActor.run {
            if case .success(_) = listResult {
                self.setList(nil)
            }
        }
        return listResult.map { _ in }
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
                self.handleWishlist(list)
            }
        }
        return listResult.map { _ in }
    }
    
    private func handleWishlist(_ wishlist: Wishlist?) {
        guard let wishlist = wishlist else {
            self.setList(nil)
            return
        }
        
        let user = authManager.state.user
        if let ownerId = wishlist.customerId {
            _ = wishlistIdStore.delete()
            if let user = user {
                if user.id == ownerId {
                    self.setList(wishlist)
                } else {
                    evaluateState()
                }
            } else {
                evaluateState()
            }
        } else if user == nil {
            _ = wishlistIdStore.write(id: wishlist.id)
            self.setList(wishlist)
        } else {
            self.setList(wishlist)
            evaluateState()
        }
    }
    
    private func setList(_ wishlist: Wishlist?) {
        if let wishlist = wishlist {
            self.state = .data(data: wishlist)
        } else {
            self.state = .none
        }
    }
}
