//
//  ShopifyLocale.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import Shopify_ITI_SDK

extension ShopifyAPI.CurrencyCode {
    var localizationKey: String {
        "currencyISO.\(rawValue)"
    }
}

extension ShopifyAPI.CountryCode {
    var localizationKey: String {
        "countryCode.\(rawValue)"
    }
}

extension ShopifyAPI.LanguageCode {
    var localizationKey: String {
        "languageCode.\(rawValue)"
    }
}
