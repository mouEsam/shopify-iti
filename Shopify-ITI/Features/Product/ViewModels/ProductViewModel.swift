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
    @Published private(set) var wishlistState: UIState<Void> = .initial
    @Published private(set) var cartState: UIState<Void> = .initial
    @Published private(set) var currentQuantity = 1
    @Published private(set) var selectedVariantId: String? = nil
    
    @Published var wishlistError: ErrorWrapper? = nil
    @Published var wishlistSuccess: IdentifiableWrapper? = nil
    @Published var cartError: ErrorWrapper? = nil
    @Published var cartSuccess: IdentifiableWrapper? = nil
    
    private var wishlistTask: Task<Void, Error>? = nil
    private var cartTask: Task<Void, Error>? = nil
    
    private let productId: String
    private let model: any AnyProductModel
    private let wishlistManager: any AnyWishlistManager
    private let cartManager: CartManager
    
    init(productId: String,
         model: some AnyProductModel,
         wishlistManager: some AnyWishlistManager,
         cartManager: CartManager) {
        self.productId = productId
        self.model = model
        self.wishlistManager = wishlistManager
        self.cartManager = cartManager
    }
    
    func initialize() async {
        wishlistManager.statePublisher
            .prepend(wishlistManager.state)
            .subscribe(on: DispatchQueue.global())
            .map { state in
                if case .none = state {
                    return false
                } else if case .data(let data) = state {
                    return data.entries[self.productId] != nil
                } else {
                    return nil
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$isWishlisted)
        
        $wishlistState.map { ErrorWrapper(optional: $0.error) }
            .receive(on: DispatchQueue.main).assign(to: &$wishlistError)
        $wishlistState.map { IdentifiableWrapper(optional: $0.data) }
            .receive(on: DispatchQueue.main).assign(to: &$wishlistSuccess)
        $cartState.map { ErrorWrapper(optional: $0.error) }
            .receive(on: DispatchQueue.main).assign(to: &$cartError)
        $cartState.map { IdentifiableWrapper(optional: $0.data) }
            .receive(on: DispatchQueue.main).assign(to: &$cartSuccess)
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
                    if let variant = data.data.variants.first(where: { $0.availableForSale }) {
                        selectedVariantId = variant.id
                        currentQuantity = min(max(1, currentQuantity),
                                              variant.quantityAvailable ?? 0)
                    }
                    break
                case .failure(let error):
                    self.uiState = .error(error: error)
            }
        }
    }
    
    func toggleWishlist() {
        if let product = uiState.data,
           let variant = product.variants.first {
            wishlistTask?.cancel()
            wishlistTask = Task {
                await MainActor.run {
                    wishlistState = .loading
                }
                let result = await wishlistManager.toggleItem(.init(productId: product.id,
                                                                    variantId: variant.id))
                await MainActor.run {
                    switch result {
                        case .success(_):
                            wishlistState = .loaded(data: SourcedData.remote(Void()))
                        case .failure(let error):
                            wishlistState = .error(error: error)
                    }
                }
            }
        }
    }
    
    func increment() {
        setQuantity(currentQuantity + 1)
    }
    
    func decrement() {
        setQuantity(currentQuantity - 1)
    }
    
    private func updateProduct(_ product: DetailedProduct) {
        var variants = product.variants
        if let variantId = selectedVariantId,
           let variantIndex = variants.firstIndex(where: { $0.id == variantId }) {
            var variant = variants[variantIndex]
            var quantity = (variant.quantityAvailable ?? 0)
            quantity -= currentQuantity
            variant.quantityAvailable = quantity
            variant.availableForSale = quantity > 0
            variants[variantIndex] = variant
            if !variant.availableForSale {
                selectedVariantId = variants.first(where: \.availableForSale)?.id
            }
        }
        var product = product
        product.variants = variants
        if let variantId = selectedVariantId,
           let variantIndex = variants.firstIndex(where: { $0.id == variantId }) {
            let variant = variants[variantIndex]
            currentQuantity = min(max(1, currentQuantity),
                                  variant.quantityAvailable ?? 0)
        } else {
            currentQuantity = 0
        }
        uiState = .loaded(data: SourcedData.local(product))
    }
    
    private func setQuantity(_ quantity: Int) {
        if case .loaded(let data) = uiState,
           let variantId = selectedVariantId,
           let variant = data.data.variants.first(where: { $0.id == variantId }) {
            currentQuantity = min(max(1, quantity), variant.quantityAvailable ?? 0)
        }
    }
    
    func select(variant: ProductVariant) {
        if case .loaded(let data) = uiState,
           data.data.variants.contains(where: { $0.availableForSale && $0.id == variant.id }) {
            selectedVariantId = variant.id
            currentQuantity = min(currentQuantity, variant.quantityAvailable ?? 0)
        }
    }
    
    func addToCart() {
        if cartTask == nil,
           let product = uiState.data,
           let variantId = selectedVariantId,
           let variant = product.variants.first(where: { $0.availableForSale && $0.id == variantId }) {
            cartTask = Task {
                await MainActor.run {
                    cartState = .loading
                }
                let result = await cartManager.addItem(productVariant: variant,
                                                       quantity: currentQuantity)
                await MainActor.run {
                    switch result {
                        case .success(_):
                            cartState = .loaded(data: SourcedData.remote(Void()))
                            self.updateProduct(product)
                        case .failure(let error):
                            cartState = .error(error: error)
                    }
                }
                cartTask = nil
            }
        }
    }
}
