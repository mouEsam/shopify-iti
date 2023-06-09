//
//  LocaleProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

// TODO: refactor to use runtime dynamic values
struct LocaleProvider: AnyLocaleProvider {
    var country: String { "US" }
    var language: String { "EN" }
}
