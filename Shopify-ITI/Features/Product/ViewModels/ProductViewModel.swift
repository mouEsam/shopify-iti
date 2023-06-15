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
    
    private let productId: String
    private let model: any AnyProductModel
    private let wishlistManager: WishlistManager
    
    init(productId: String,
         model: some AnyProductModel,
         wishlistManager: WishlistManager) {
        self.productId = productId
        self.model = model
        self.wishlistManager = wishlistManager
        
        self.initialize()
    }
    
    private func initialize() {
        wishlistManager.$state
            .subscribe(on: DispatchQueue.global())
            .compactMap(\.data)
            .map({ $0.entries[self.productId] != nil })
            .receive(on: DispatchQueue.main)
            .assign(to: &$isWishlisted)
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
}
