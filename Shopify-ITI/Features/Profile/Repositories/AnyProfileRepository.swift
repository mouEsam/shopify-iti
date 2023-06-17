//
//  AnyProfileREpository.swift
//  Shopify-ITI
//
//  Created by ammar on 17/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import Shopify_Admin_ITI_SDK

protocol AnyProfileRepository : AnyInjectable {
    typealias ProfileError = ShopifyErrors<ShopifyAPI.CustomerErrorCode>
    typealias WishlistError = ShopifyErrors<Any>
    
    func profile() async -> Result<User, ProfileError>
    
    func getOrders() async -> Result<Any, Error>
}
