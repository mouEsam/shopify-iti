//
//  KeysProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

struct KeysProvider: AnyKeysProvider, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyKeysProvider).self) { resolver in
            KeysProvider()
        }
    }
    
    let userLocalKey: String = "user_local"
    let guestLocalKey: String = "guest_local"
    let accessTokenLocalKey: String = "access_token_local"
    let wishlistRemoteKey: String = "wishlist_remote"
    let cartRemoteKey: String = "cart_remote"
    let countryLocalKey: String = "conutry_local"
    let languageLocalKey: String = "AppleLanguages"
    let previousSearchesLocalKey: String = "previous_seaches"
}
