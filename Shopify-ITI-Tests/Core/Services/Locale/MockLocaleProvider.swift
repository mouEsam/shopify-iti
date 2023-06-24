//
//  MockLocaleProvider.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockLocaleProvider: AnyLocaleProvider {
    
    var provider: AnyLocaleProvider? = nil
    
    var localeResult: Locale! = nil
    var countryResult: String! = nil
    var languageResult: String! = nil
    
    var locale: Locale {
        if let provider = provider {
            return provider.locale
        } else {
            return localeResult
        }
    }
    
    var country: String {
        if let provider = provider {
            return provider.country
        } else {
            return countryResult
        }
    }
    
    var language: String {
        if let provider = provider {
            return provider.language
        } else {
            return languageResult
        }
    }
}
