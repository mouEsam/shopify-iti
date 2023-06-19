//
//  ProductViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation
import Combine

class ProductViewModel: ObservableObject {
    
    @Published private(set) var isWishlisted: Bool? = nil
    @Published private(set) var uiState: UIState<DetailedProduct> = .initial
    @Published private(set) var currentQuantity = 1
    @Published private(set) var selectedVariantId: String? = nil
    
    private let productId: String
    private let model: any AnyProductModel
    private let wishlistManager: WishlistManager
    
    init(productId: String,
         model: some AnyProductModel,
         wishlistManager: WishlistManager) {
        self.productId = productId
        self.model = model
        self.wishlistManager = wishlistManager
    }
    
    func initialize() async {
        wishlistManager.$state
            .subscribe(on: DispatchQueue.global())
            .map {
                print($0)
                return $0.data
            }
            .map({ $0.map { $0.entries[self.productId] != nil } })
            .receive(on: DispatchQueue.main)
            .assign(to: &$isWishlisted)
        await fetch()
    }
    
    func fetch() async {
        await MainActor.run {
            self.uiState = .loading
        }
        let result = await model.fetch(byId: productId)
        await MainActor.run {
            switch result {
                case .success(let data):
                    self.uiState = .loaded(data: data)
                    let variant = data.data.variants.first
                    selectedVariantId = variant?.id
                    break
                case .failure(let error):
                    self.uiState = .error(error: error)
            }
        }
    }
    
    func toggleWishlist() async -> Result<Void, ShopifyErrors<Any>> {
        if let product = uiState.data,
           let variant = product.variants.first,
           let wishlisted = isWishlisted {
            if wishlisted {
                return await wishlistManager.removeItem(.init(productId: product.id,
                                                              variantId: variant.id))
            } else {
                return await wishlistManager.addItem(.init(productId: product.id,
                                                           variantId: variant.id))
            }
        }
        return .failure(.Unknown)
    }
    
    func increment() {
        setQuantity(currentQuantity + 1)
    }
    
    func decrement() {
        setQuantity(currentQuantity - 1)
    }
    
    private func setQuantity(_ quantity: Int) {
        if case .loaded(let data) = uiState,
           let variantId = selectedVariantId,
           let variant = data.data.variants.first(where: { $0.id == variantId }) {
            currentQuantity = min(quantity, variant.quantityAvailable ?? 0)
        }
    }
    
    func select(variant: ProductVariant) {
        if case .loaded(let data) = uiState,
           data.data.variants.contains(where: { $0.id == variant.id }) {
            selectedVariantId = variant.id
            currentQuantity = min(currentQuantity, variant.quantityAvailable ?? 0)
        }
    }
}
