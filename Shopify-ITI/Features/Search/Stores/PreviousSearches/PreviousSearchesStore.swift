//
//  PreviousSearchesStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation

struct PreviousSearchesStore: AnyPreviousSearchesStore, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyPreviousSearchesStore).self) { resolver in
            PreviousSearchesStore(userDefaults: resolver.require(UserDefaults.self),
                                  keysProvider: resolver.require((any AnyKeysProvider).self))
        }
    }
    
    private let userDefaults: UserDefaults
    private let keysProvider: any AnyKeysProvider
    
    func exists() -> Bool {
        return userDefaults.data(forKey: keysProvider.previousSearchesLocalKey) != nil
    }
    
    func read() -> [String]? {
        userDefaults.stringArray(forKey: keysProvider.previousSearchesLocalKey)
    }
    
    func write(searches: [String]) {
        userDefaults.set(searches, forKey: keysProvider.previousSearchesLocalKey)
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.previousSearchesLocalKey)
    }
}
