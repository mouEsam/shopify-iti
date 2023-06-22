//
//  TokenProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyAccessTokenHolder: AnyObject, AnyAccessTokenProvider {
    var accessToken: String? { get set }
}

class AccessTokenHolder: AnyAccessTokenHolder {
    static func register(_ container: AppContainer) {
        container.register(type: AccessTokenHolder.self) { resolver in
            AccessTokenHolder()
        }
        .implements((any AnyAccessTokenProvider).self)
        .implements((any AnyAccessTokenHolder).self)
    }
    
    var accessToken: String?
}
