//
//  CountryLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

struct CountryLocalStore: AnyCountryLocalStore {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCountryLocalStore).self) { resolver in
            CountryLocalStore(userDefaults: resolver.require(UserDefaults.self),
                            keysProvider: resolver.require((any AnyKeysProvider).self))
        }
    }
    
    private let userDefaults: UserDefaults
    private let keysProvider: any AnyKeysProvider
    
    func read() -> String? {
        return userDefaults.string(forKey: keysProvider.countryLocalKey)
    }
    
    func write(country: String) {
        userDefaults.set(country, forKey: keysProvider.countryLocalKey)
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.countryLocalKey)
    }
}
