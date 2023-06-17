//
//  CartIdStore.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
struct CartIdStore:AnyCartIdStore {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCartIdStore).self) { resolver in
            CartIdStore(userDefaults: resolver.require(UserDefaults.self),
                        keysProvider: resolver.require((any AnyKeysProvider).self))
        }
    }
    
   
    
    private let userDefaults: UserDefaults
    private let keysProvider: any AnyKeysProvider
    
    func exists() -> Bool {
        return userDefaults.data(forKey: keysProvider.cartRemoteKey) != nil
    }
    
    func read() -> Result<String, LocalErrors> {
        if let data = userDefaults.data(forKey: keysProvider.cartRemoteKey) {
            if let id = String(data: data, encoding: .utf8) {
                return .success(id)
            } else {
                return .failure(LocalErrors.Invalid)
            }
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func write(id: String) -> Result<Void, LocalErrors> {
        let data = id.data(using: .utf8)
        return .success(userDefaults.set(data, forKey: keysProvider.cartRemoteKey))
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.cartRemoteKey)
    }
}
