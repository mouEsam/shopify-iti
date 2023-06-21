//
//  WishlistManager.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Combine
import Semaphore

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
    
    private let semaphore = AsyncSemaphore(value: 1)
    private var task: Task<Any, Error>? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    @PostPublished private var stateHolder: State = .loading
    var statePublisher: PostPublished<State>.Publisher { $stateHolder }
    var state: State { stateHolder }
    
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
        authManager.statePublisher
            .prepend(authManager.state)
            .receive(on: DispatchQueue.global()).sink { authState in
                self.handleAuthState(authState)
            }.store(in: &cancellables)
    }
    
    func refreshState() {
        handleAuthState(authManager.state)
    }
    
    private func handleAuthState(_ authState: AuthenticationState) {
        task?.cancel()
        task = Task {
            try? await semaphore.withUnlessCancelled {
                await handleAuthStateImpl(authState, self.state.data)
            }
            return
        }
    }
    
    private func handleAuthStateImpl(_ authState: AuthenticationState,
                                     _ wishlist: Wishlist?) async {
        await MainActor.run {
            self.stateHolder = .loading
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
            self.stateHolder = .data(data: wishlist)
        }
    }
    
    private func removeList() async {
        wishlistIdStore.delete()
        await MainActor.run {
            self.stateHolder = .none
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
                    self.stateHolder = .error(error: error)
                    break
            }
        }
    }
    
    func toggleItem(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        return await doAction {
            if case .error(let error) = self.state {
                return .failure(.Client(error: error))
            }
            return await self.toggleItemImpl(item, self.state.data)
        }
    }
    
    private func toggleItemImpl(_ item: WishListEntry, _ wishlist: Wishlist?) async -> Result<Void, ShopifyErrors<Any>> {
        if let wishlist = wishlist {
            if let _ = wishlist.entries[item.productId] {
                return await removeItemImpl(item, wishlist)
            } else {
                return await addItemImpl(item, wishlist)
            }
        } else {
            return await addItemImpl(item, wishlist)
        }
    }
    
    func addItem(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        return await doAction {
            if case .error(let error) = self.state {
                return .failure(.Client(error: error))
            }
            return await self.addItemImpl(item, self.state.data)
        }
    }
    
    private func addItemImpl(_ item: WishListEntry, _ wishlist: Wishlist?) async -> Result<Void, ShopifyErrors<Any>> {
        if let wishlist = wishlist {
            let result = await addToList(wishlist, item)
            if case .success(_) = result {
                notificationCenter.post(WishlistAddedEntryNotification(wishlist: wishlist,
                                                                       entry: item))
            }
            return result
        }
        return await createList(item)
    }
    
    func removeItem(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        return await doAction {
            if case .error(let error) = self.state {
                return .failure(.Client(error: error))
            }
            return await self.removeItemImpl(item, self.state.data)
        }
    }
    
    private func doAction(_ action: @escaping () async -> Result<Void, ShopifyErrors<Any>>) async -> Result<Void, ShopifyErrors<Any>> {
        _ = await task?.result
        guard let result = try? await semaphore.withUnlessCancelled(criticalSection: action) else {
            return self.cancellation()
        }
        return result
    }
    
    private func cancellation() -> Result<Void, ShopifyErrors<Any>> {
        .failure(.Cancelled)
    }
    
    private func removeItemImpl(_ item: WishListEntry, _ wishlist: Wishlist?) async -> Result<Void, ShopifyErrors<Any>> {
        if let wishlist = wishlist {
            let result = await removeFromList(wishlist, item)
            if case .success(_) = result {
                notificationCenter.post(WishlistRemovedEntryNotification(wishlist: wishlist,
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
        guard !Task.isCancelled else { return .failure(.Cancelled) }
        
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
    
    private func createList(_ item: WishListEntry) async -> Result<Void, ShopifyErrors<Any>> {
        let listResult = await wishlistService.create(with: item)
        return await handleUpdatedListResult(listResult)
    }
    
    private func handleUpdatedListResult(_ listResult: Result<Wishlist, ShopifyErrors<Any>>) async -> Result<Void, ShopifyErrors<Any>> {
        guard !Task.isCancelled else { return .failure(.Cancelled) }
        
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
                    refreshState()
                }
            } else {
                refreshState()
            }
        } else if user == nil {
            _ = wishlistIdStore.write(id: wishlist.id)
            self.setList(wishlist)
        } else {
            self.setList(wishlist)
            refreshState()
        }
    }
    
    private func setList(_ wishlist: Wishlist?) {
        if let wishlist = wishlist {
            self.stateHolder = .data(data: wishlist)
        } else {
            self.stateHolder = .none
        }
    }
}
