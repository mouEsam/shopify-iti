//
//  LocaleProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

// TODO: refactor to use runtime dynamic values
struct LocaleProvider: AnyLocaleProvider {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyLocaleProvider).self) { resolver in
            LocaleProvider()
        }
    }
    
    var country: String { "US" }
    var language: String { "EN" }
}
