//
//  MainScreenViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import Combine

class MainScreenViewModel: ObservableObject {
    
    @Published private(set) var wishlistCount: Int? = nil
    @Published private(set) var cartCount: Int? = nil

    private let wishlistManager: WishlistManager
    private let cartManager: CartManager
    
    init(wishlistManager: WishlistManager,
         cartManager: CartManager) {
        self.wishlistManager = wishlistManager
        self.cartManager = cartManager
        
        self.initialize()
    }
    
    private func initialize() {
        wishlistManager.statePublisher
            .prepend(wishlistManager.state)
            .map(\.data?.entries.count)
            .assign(to: &$wishlistCount)
        cartManager.statePublisher
            .prepend(cartManager.state)
            .map(\.data?.cartLine.count)
            .assign(to: &$cartCount)
    }
}
