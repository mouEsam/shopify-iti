//
//  ProductsViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation
import Combine

class ProductsViewModel: ObservableObject {
    typealias Criterion = [ProductSearchCriteria : String]
    
    private let model: any AnyProductsModel
    private let wishlistManager: WishlistManager
    private let notificationCenter: any AnyNotificationCenter
    
    @Published private(set) var uiState: UIState<[ListableProduct]> = .initial
    @Published private(set) var operationState: UIState<Void> = .initial
    @Published private(set) var criterion: Criterion
    
    private var cancellables: Set<AnyCancellable> = []
    private var pageInfo: PageInfo? = nil
    private var fetchTask: Task<Any, Error>? = nil
    
    init(criterion: Criterion,
         model: some AnyProductsModel,
         wishlistManager: WishlistManager,
         notificationCenter: some AnyNotificationCenter) {
        self.criterion = criterion
        self.model = model
        self.wishlistManager = wishlistManager
        self.notificationCenter = notificationCenter
        
        initialize()
    }
    
    private func initialize() {
        wishlistManager.$state
            .compactMap(\.data)
            .first()
            .subscribe(on: DispatchQueue.global())
            .compactMap { wishlist in
                if let list = self.uiState.data {
                    return self.applyWishlist(list)
                }
                return nil
            }.receive(on: DispatchQueue.main)
            .sink { list in
                self.uiState = .loaded(data: SourcedData.remote(list))
            }.store(in: &cancellables)
        
        notificationCenter.publisher(for: WishlistRemovedEntryNotification.name)
            .compactMap { $0.object as? WishlistRemovedEntryNotification }
            .sink { event in
                self.setRemovedFromWishlist(event.entry)
            }.store(in: &cancellables)
        
        notificationCenter.publisher(for: WishlistAddedEntryNotification.name)
            .compactMap { $0.object as? WishlistAddedEntryNotification }
            .sink { event in
                self.setAddedToWishlist(event.entry)
            }.store(in: &cancellables)
    }
    
    func setCriteria(_ criteria: ProductSearchCriteria, _ value: String?) {
        self.criterion[criteria] = value
    }
    
    func getCriteria(_ criteria: ProductSearchCriteria) -> String? {
        return self.criterion[criteria]
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
    
    func toggleWishlist(item: Product) async -> Result<Void, ShopifyErrors<Any>> {
        return await wishlistManager.toggleItem(.init(productId: item.id,
                                                      variantId: item.variantId))
    }
    
    private func fetchImpl() async {
        await updateState(.loading, .loading)
        let result = await model.fetch(withCriteria: criterion, with: pageInfo)
        
        guard !Task.isCancelled else { return }
        
        switch result {
            case .success(let page):
                let page =  page.data
                var existingList = uiState.data ?? []
                existingList.append(contentsOf: applyWishlist(page.list))
                await setLoaded(existingList)
                pageInfo = page.pageInfo
                return
            case .failure(let error):
                await setError(error)
                return
        }
    }
    
    private func applyWishlist(_ list: [Product]) -> [ListableProduct] {
        if let wishlist = wishlistManager.state.data {
            return list.map { .init(product: $0,
                                    isWishlisted: wishlist.entries[$0.id] != nil) }
        }
        return list.map { .init(product: $0) }
    }
    
    private func applyWishlist(_ list: [ListableProduct]) -> [ListableProduct] {
        if let wishlist = wishlistManager.state.data {
            return list.map { $0.copyWith(isWishlisted: wishlist.entries[$0.id] != nil) }
        }
        return list
    }
    
    private func setRemovedFromWishlist(_ entry: WishListEntry) {
        setWishlisted(entry, false)
    }
    
    private func setAddedToWishlist(_ entry: WishListEntry) {
        setWishlisted(entry, true)
    }
    
    private func setWishlisted(_ entry: WishListEntry, _ wishlisted: Bool) {
        if var list = uiState.data,
           let index = list.firstIndex(where: { $0.id == entry.productId }){
            let item = list[index].copyWith(isWishlisted: wishlisted)
            list[index] = item
            uiState = .loaded(data: SourcedData.remote(list))
        }
    }
    
    private func setInitial() async {
        await updateState(.initial, .initial)
    }
    
    private func setClear() async {
        await updateState(.loaded(data: SourcedData.local([])), .initial)
    }
    
    private func setLoaded(_ list: [ListableProduct]) async {
        await MainActor.run {
            self.uiState = .loaded(data: SourcedData.remote(list))
            self.operationState = .initial
        }
    }
    
    private func setLoading() async {
        await updateState(.loading, .loading)
    }
    
    private func setError(_ error: Error) async {
        await updateState(.error(error: error), .error(error: error))
    }
    
    private func updateState(_ uiState: UIState<[ListableProduct]>,
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
