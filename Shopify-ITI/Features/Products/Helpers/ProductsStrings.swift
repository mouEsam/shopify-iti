//
//  ProductsStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation

protocol AnyProductsStrings {
    var noProductsLabel: String { get }
    var wishlistErrorLabel: String { get }
}
// TODO: localize
struct ProductsStrings: AnyProductsStrings, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProductsStrings).self) { resolver in
            ProductsStrings()
        }
    }
    
    let noProductsLabel = "ProductsStrings.noProductsLabel"
    let wishlistErrorLabel = "ProductsStrings.wishlistErrorLabel"
    
}
