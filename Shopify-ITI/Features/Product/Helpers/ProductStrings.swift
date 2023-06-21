//
//  ProductStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation

protocol AnyProductStrings {
    var addToCartLabel: String { get }
    var addToCartError: String { get }
    var addToCartSuccess: String { get }
    var addToCartSuccessMessage: String { get }
    var wishlistError: String { get }
}
// TODO: localize
struct ProductStrings: AnyProductStrings, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProductStrings).self) { resolver in
            ProductStrings()
        }
    }
    
    let addToCartLabel = "ProductStrings.addToCartLabel"
    let addToCartError = "ProductStrings.addToCartError"
    let addToCartSuccess = "ProductStrings.addToCartSuccess"
    let addToCartSuccessMessage = "ProductStrings.addToCartSuccessMessage"
    let wishlistError = "ProductStrings.wishlistError"
    
}
