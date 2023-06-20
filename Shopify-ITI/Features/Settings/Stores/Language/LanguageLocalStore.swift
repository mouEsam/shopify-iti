//
//  LanguageLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

struct LanguageLocalStore: AnyLanguageLocalStore {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyLanguageLocalStore).self) { resolver in
            LanguageLocalStore(userDefaults: UserDefaults.standard,
                            keysProvider: resolver.require((any AnyKeysProvider).self))
        }
    }
    
    private let userDefaults: UserDefaults
    private let keysProvider: any AnyKeysProvider
    
    func read() -> Result<String, LocalErrors> {
        if let languages = userDefaults.stringArray(forKey: keysProvider.languageLocalKey),
           let language = languages.first {
            return .success(language)
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func write(language: String) {
        userDefaults.set([language], forKey: keysProvider.languageLocalKey)
        userDefaults.synchronize()
    }
}

