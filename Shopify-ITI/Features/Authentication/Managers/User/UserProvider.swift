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

class UserHolder: AnyUserHolder, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: UserHolder.self) { resolver in
            UserHolder()
        }
        .implements((any AnyUserHolder).self)
        .implements((any AnyUserProvider).self)
    }
    
    var user: User?
}
