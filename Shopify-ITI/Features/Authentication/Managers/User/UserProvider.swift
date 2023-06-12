//
//  UserProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation

protocol AnyUserHolder: AnyObject, AnyUserProvider {
    var user: User? { get set }
}

class UserHolder: AnyUserHolder {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyUserHolder).self) { resolver in
            UserHolder()
        }
        container.register(type: (any AnyUserProvider).self) { resolver in
            resolver.require((any AnyUserHolder).self)
        }
    }
    
    var user: User?
}
