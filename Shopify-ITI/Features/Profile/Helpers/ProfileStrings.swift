//
//  ProfileStrings.swift
//  Shopify-ITI
//
//  Created by ammar on 18/06/2023.
//

import Foundation

protocol AnyProfileStrings {
    var orderLabel: String { get }
    var welcomeLabel: String { get }
    var wishlsitLabel: String { get }
    var moreLabel: String { get }
    var loginAction: String { get }
   
}
// TODO: localize
struct ProfileStrings: AnyProfileStrings, AnyInjectable  {
    

    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProfileStrings).self) { resolver in
            ProfileStrings()
        }
    }
    var orderLabel: String = "Order"
    
    var welcomeLabel: String = "Welcome"
    
    var wishlsitLabel: String = "Wishlist"
    
    var moreLabel: String = "More"
    
    var loginAction: String = "Please Login"
}
