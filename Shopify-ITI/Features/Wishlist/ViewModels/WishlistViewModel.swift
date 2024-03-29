//
//  WishlistViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Combine

class WishlistViewModel: ObservableObject {
    
    @globalActor
    actor Actor {
        static let shared: Actor = Actor()
    }
    
    private let model: any AnyWishlistModel
    private let wishlistManager: any AnyWishlistManager
    private let notificationCenter: any AnyNotificationCenter
    private let queue: DispatchQueue = DispatchQueue(label: "WishlistViewModel")
    
    @Published private(set) var uiState: UIState<[WishlistItem]> = .initial
    @Published private(set) var operationState: UIState<Void> = .initial
    
    private var cancellables: Set<AnyCancellable> = []
    private(set) var pageInfo: PageInfo? = nil
    private var fetchTask: Task<Any, Error>? = nil
    
    init(model: some AnyWishlistModel,
         wishlistManager: some AnyWishlistManager,
         notificationCenter: some AnyNotificationCenter) {
        self.model = model
        self.wishlistManager = wishlistManager
        self.notificationCenter = notificationCenter
    }
    
    func initialize() {
        wishlistManager.statePublisher
            .prepend(wishlistManager.state)
            .map(\.bare)
            .removeDuplicates()
            .receive(on: queue)
            .sink { state in
                self.handleWishlistState(state)
            }.store(in: &cancellables)
        
        notificationCenter.publisher(for: WishlistRemovedEntryNotification.name)
            .compactMap { $0.object as? WishlistRemovedEntryNotification }
            .receive(on: queue)
            .sink { event in
                self.onItemRemoved(event.entry)
            }.store(in: &cancellables)
        
        notificationCenter.publisher(for: WishlistAddedEntryNotification.name)
            .compactMap { $0.object as? WishlistAddedEntryNotification }
            .receive(on: queue)
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
    
    private func onItemRemoved(_ entry: WishListEntry) {
        Task {
            await onItemRemovedImpl(entry)
        }
    }
    
    @Actor private func onItemRemovedImpl(_ entry: WishListEntry) async {
        if case .loaded(let data) = self.uiState,
           let index = data.data.firstIndex(where: {
               $0.product.id == entry.productId
           }){
            var newList = data.data
            newList.remove(at: index)
            self.setList(newList)
        }
    }
    
    private func setList(_ list: [WishlistItem]) {
        fetchTask?.cancel()
        fetchTask = Task {
            await MainActor.run {
                self.uiState = .loaded(data: SourcedData.remote(list))
                self.operationState = .initial
                return
            }
        }
    }
    
    private func fetchImpl() async {
        if let wishlistId = wishlistManager.state.data?.id {
            await updateState(.loading, .loading)
            let result = await model.fetch(for: wishlistId, with: pageInfo)
            
            guard !Task.isCancelled else { return }
            
            await handleFetchResult(result)
        } else {
            await handleNoFetch()
        }
    }
    
    @Actor private func handleFetchResult(_ result: Result<SourcedData<PageResult<WishlistItem>>, ShopifyErrors<Any>>) async {
        switch result {
            case .success(let page):
                let page = page.data
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
    
    @Actor private func handleNoFetch() async {
        await setLoaded([])
    }
    
    private func handleWishlistState(_ state: BareResource) {
        fetchTask?.cancel()
        fetchTask = Task {
            self.pageInfo = nil
            switch state {
                case .loading:
                    await self.setLoading()
                    break
                case .error:
                    wishlistManager.refreshState()
                    if let error = wishlistManager.state.error {
                        await self.setError(error)
                    }
                    break
                default:
                    await self.fetchImpl()
            }
            return
        }
    }
    
    @Actor private func setInitial() async {
        await updateState(.initial, .initial)
    }
    
    @Actor private func setClear() async {
        await updateState(.loaded(data: SourcedData.local([])), .initial)
    }
    
    @Actor private func setLoaded(_ list: [WishlistItem]) async {
        await MainActor.run {
            self.uiState = .loaded(data: SourcedData.remote(list))
            self.operationState = .initial
        }
    }
    
    @Actor private func setLoading() async {
        await updateState(.loading, .loading)
    }
    
    @Actor private func setError(_ error: Error) async {
        await updateState(.error(error: error), .error(error: error))
    }
    
    @Actor private func updateState(_ uiState: UIState<[WishlistItem]>,
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
