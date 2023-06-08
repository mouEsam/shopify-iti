//
//  AnyLocaleProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

protocol AnyLocaleProvider {
    var country: String { get }
    var language: String { get }
}

extension AnyLocaleProvider {
    var shopifyCountry: GraphQLEnum<ShopifyAPI.CountryCode>? { .init(rawValue: country) }
    var shopifyLanguage: GraphQLEnum<ShopifyAPI.LanguageCode>? { .init(rawValue: language) }
}
