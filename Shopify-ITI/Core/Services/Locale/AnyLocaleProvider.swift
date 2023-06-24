//
//  AnyLocaleProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation
import Apollo
import Shopify_ITI_SDK
import Shopify_Admin_ITI_SDK

protocol AnyLocaleProvider {
    var locale: Locale { get }
    var country: String { get }
    var language: String { get }
}

extension AnyLocaleProvider {
    var shopifyCountry: GraphQLEnum<ShopifyAPI.CountryCode>? {
        return .init(rawValue: country)
    }
    
    var shopifyLanguage: GraphQLEnum<ShopifyAPI.LanguageCode>? {
        return .init(rawValue: language)
    }
    
    var shopifyAdminCountry: GraphQLEnum<ShopifyAdminAPI.CountryCode>? {
        return .init(rawValue: country)
    }
}
