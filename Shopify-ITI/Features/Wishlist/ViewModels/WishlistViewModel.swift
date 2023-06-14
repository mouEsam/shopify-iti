//
//  WishlistViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Combine

class WishlistViewModel: ObservableObject {
    
    private let model: any AnyWishlistModel
    private let wishlistManager: WishlistManager
    private let notificationCenter: any AnyNotificationCenter
    
    @Published private(set) var uiState: UIState<[WishlistItem]> = .initial
    @Published private(set) var operationState: UIState<Void> = .initial
    
    private var cancellables: Set<AnyCancellable> = []
    private var pageInfo: PageInfo? = nil
    private var fetchTask: Task<Any, Error>? = nil
    
    init(model: some AnyWishlistModel,
         wishlistManager: WishlistManager,
         notificationCenter: some AnyNotificationCenter) {
        self.model = model
        self.wishlistManager = wishlistManager
        self.notificationCenter = notificationCenter
        
        initialize()
    }
    
    private func initialize() {
        wishlistManager.$state
            .prepend(wishlistManager.state)
            .map(\.data?.id)
            .removeDuplicates()
            .sink { wishlistId in
                if wishlistId == nil {
                    self.clear()
                } else {
                    self.refetch()
                }
            }.store(in: &cancellables)
        
        notificationCenter.publisher(for: WishlistRemovedEntryNotification.name)
            .compactMap { $0.object as? WishlistRemovedEntryNotification }
            .sink { event in
                if case .loaded(let data) = self.uiState,
                   let index = data.data.firstIndex(where: {
                       $0.product.id == event.entry.productId
                   }){
                    var newList = data.data
                    newList.remove(at: index)
                    self.uiState = .loaded(data: SourcedData.remote(newList))
                }
            }.store(in: &cancellables)
        
        notificationCenter.publisher(for: WishlistAddedEntryNotification.name)
            .compactMap { $0.object as? WishlistAddedEntryNotification }
            .sink { event in
                self.refetch()
            }.store(in: &cancellables)
    }
    
    func fetch() {
        fetchTask?.cancel()
        fetchTask = Task {
            return await self.fetchImpl()
        }
    }
    
    func refetch() {
        fetchTask?.cancel()
        fetchTask = Task {
            self.pageInfo = nil
            return await self.fetchImpl()
        }
    }
    
    func clear() {
        fetchTask?.cancel()
        fetchTask = Task {
            self.pageInfo = nil
            return await setClear()
        }
    }
    
    func remove(item: WishlistItem) async -> Result<Void, ShopifyErrors<Any>> {
        return await wishlistManager.removeItem(.init(productId: item.product.id,
                                                      variantId: item.variant.id))
    }
    
    private func fetchImpl() async {
        guard let wishlistId = wishlistManager.state.data?.id else { return }
        await updateState(.loading, .loading)
        let result = await model.fetch(for: wishlistId, with: pageInfo)
        
        guard !Task.isCancelled else { return }
        
        switch result {
            case .success(let page):
                var existingList = uiState.data ?? []
                existingList.append(contentsOf: page.list)
                await setLoaded(existingList)
                pageInfo = page.pageInfo
                return
            case .failure(let error):
                await setError(error)
                return
        }
    }
    
    private func setInitial() async {
        await updateState(.initial, .initial)
    }
    
    private func setClear() async {
        await updateState(.loaded(data: SourcedData.local([])), .initial)
    }
    
    private func setLoaded(_ list: [WishlistItem]) async {
        await updateState(.loaded(data: SourcedData.remote(list)), .initial)
    }
    
    private func setLoading() async {
        await updateState(.loading, .loading)
    }
    
    private func setError(_ error: Error) async {
        await updateState(.error(error: error), .error(error: error))
    }
    
    private func updateState(_ uiState: UIState<[WishlistItem]>,
                             _ opState: UIState<Void>) async {
        await MainActor.run {
            if self.pageInfo == nil {
                self.uiState = uiState
            } else {
                self.operationState = opState
            }
        }
    }
}