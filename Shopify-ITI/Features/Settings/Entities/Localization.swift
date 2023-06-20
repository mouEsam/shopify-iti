//
//  Localization.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct Localization {
    let countries: [ShopifyAPI.CountryCode]
    let languages: [ShopifyAPI.LanguageCode]
}

extension Localization {
    init(item: some LocalizationConvertible) {
        self.init(countries: item.availableCountries.map(\.countryCode),
                  languages: item.availableLanguages.map(\.languageCode))
    }
}

extension ShopifyAPI.CountryCode: Identifiable {
    public var id: Self { self }
}

extension ShopifyAPI.LanguageCode: Identifiable {
    public var id: Self { self }
}

protocol LocalizationConvertible {
    associatedtype Country: CountryConvertible
    associatedtype Language: LanguageConvertible
    
    var availableCountries: [Country] { get }
    var availableLanguages: [Language] { get }
}

protocol CountryConvertible {
    var countryCode: ShopifyAPI.CountryCode { get }
}

protocol LanguageConvertible {
    var languageCode: ShopifyAPI.LanguageCode { get }
}

extension ShopifyAPI.GetCountriesAndLanguagesQuery.Data.Localization: LocalizationConvertible {}

extension ShopifyAPI.GetCountriesAndLanguagesQuery.Data.Localization.AvailableCountry: CountryConvertible {
    var countryCode: ShopifyAPI.CountryCode { isoCode.value! }
}
extension ShopifyAPI.GetCountriesAndLanguagesQuery.Data.Localization.AvailableLanguage: LanguageConvertible {
    var languageCode: ShopifyAPI.LanguageCode { isoCode.value! }
}
