//
//  WishlistStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation

protocol AnyWishlistStrings {
    var noProductsLabel: String { get }
    var wishlistErrorLabel: String { get }
}
// TODO: localize
struct WishlistStrings: AnyWishlistStrings, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyWishlistStrings).self) { resolver in
            WishlistStrings()
        }
    }
    
    let noProductsLabel = "Empty"
    let wishlistErrorLabel = "Error"
    
}
