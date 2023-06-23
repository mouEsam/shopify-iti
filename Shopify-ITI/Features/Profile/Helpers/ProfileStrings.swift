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
    var loginMessage: String { get }
    var emptyListWishList: String { get }
    var emptyListOrders: String { get }
   
}

struct ProfileStrings: AnyProfileStrings, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProfileStrings).self) { resolver in
            ProfileStrings()
        }
    }
    let emptyListWishList: String = "ProfileStrings.emptyListWishList"
    
    let emptyListOrders: String = "ProfileStrings.emptyListOrders"

    
    let orderLabel: String = "ProfileStrings.orderLabel"
    
    let welcomeLabel: String = "ProfileStrings.welcomeLabel"
    
    let wishlsitLabel: String = "ProfileStrings.wishlsitLabel"
    
    let moreLabel: String = "ProfileStrings.moreLabel"
    
    let loginAction: String = "ProfileStrings.loginAction"
    let loginMessage: String = "ProfileStrings.loginMessage"

}
