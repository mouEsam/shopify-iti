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
    
    func exists() -> Bool {
        return userDefaults.data(forKey: keysProvider.countryLocalKey) != nil
    }
    
    func read() -> Result<String, LocalErrors> {
        if let data = userDefaults.data(forKey: keysProvider.countryLocalKey) {
            if let id = String(data: data, encoding: .utf8) {
                return .success(id)
            } else {
                return .failure(LocalErrors.Invalid)
            }
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func write(country: String) -> Result<Void, LocalErrors> {
        let data = country.data(using: .utf8)
        return .success(userDefaults.set(data, forKey: keysProvider.countryLocalKey))
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.countryLocalKey)
    }
}
