//
//  LocaleProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

class LocaleProvider: AnyLocaleProvider {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyLocaleProvider).self) { resolver in
            LocaleProvider()
        }
        container.register(type: LocaleProvider.self) { resolver in
            LocaleProvider()
        }
    }
    
    var locale: Locale {
        let identifier = "\(language.lowercased())_\(country.uppercased())"
        return Locale(identifier: identifier)
    }
    
    var country: String = "US"
    var language: String = "EN" 
    
    func changeLanguage(language: String ) {
        self.language = language
    }
    
    func changeCountry(country: String ) {
        self.country = country
    }
}
