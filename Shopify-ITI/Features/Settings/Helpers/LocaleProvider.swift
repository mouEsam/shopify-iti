//
//  LocaleProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

class LocaleProvider: AnyLocaleProvider {
    static func register(_ container: AppContainer) {
        container.register(type: LocaleProvider.self) { resolver in
            LocaleProvider(languageStore: resolver.require((any AnyLanguageLocalStore).self),
                           countryStore: resolver.require((any AnyCountryLocalStore).self))
        }
        .implements((any AnyLocaleProvider).self)
    }
    
    private let languageStore: any AnyLanguageLocalStore
    private let countryStore: any AnyCountryLocalStore
    
    init(languageStore: some AnyLanguageLocalStore,
         countryStore: some AnyCountryLocalStore) {
        self.languageStore = languageStore
        self.countryStore = countryStore
    }
    
    var locale: Locale {
        let identifier = "\(language.lowercased())_\(country.uppercased())"
        return Locale(identifier: identifier)
    }
    
    var country: String {
        get { countryStore.read()?.uppercased() ?? "EG" }
        set { countryStore.write(country: newValue.lowercased()) }
    }
    
    var language: String {
        get { languageStore.read()?.uppercased() ?? "EN" }
        set { languageStore.write(language: newValue.lowercased()) }
    }
}
