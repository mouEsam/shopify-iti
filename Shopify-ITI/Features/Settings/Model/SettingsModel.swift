//
//  SettingModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct SettingsModel: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: SettingsModel.self){resolver in
            SettingsModel(remoteService: resolver.require(LocalizationRemoteService.self),
                          localeProvider: resolver.require(LocaleProvider.self),
                         notificationCenter: resolver.require((any AnyNotificationCenter).self))
            
        }
    }
    
    private let remoteService: LocalizationRemoteService
    private let localeProvider: LocaleProvider
    private let notificationCenter :any AnyNotificationCenter
    
    func fetch() async -> Result<SourcedData<Localization>, ShopifyErrors<Any>> {
        let result = await remoteService.fetch()
        return result.map {
            let language = getLanguage()
            let country = getCountry()
            
            var languages = $0.languages
            var countries = $0.countries
            
            if !languages.contains(where: { $0 == language }) {
                languages.insert(language, at: 0)
            }
            if !languages.contains(where: { $0 == .ar }) {
                languages.insert(.ar, at: 0)
            }
            if !languages.contains(where: { $0 == .en }) {
                languages.insert(.en, at: 0)
            }
            if !countries.contains(where: { $0 == country }) {
                countries.insert(country, at: 0)
            }
            return .remote(.init(countries: countries,
                                 languages: languages))
        }
    }
    
    func getLanguage() -> ShopifyAPI.LanguageCode {
        if let language = localeProvider.shopifyLanguage?.value {
            return language
        } else {
            return .en
        }
    }
    
    func getCountry() -> ShopifyAPI.CountryCode {
        if let country = localeProvider.shopifyCountry?.value {
            return country
        } else {
            return .eg
        }
    }
    
    func changelanguage(language: ShopifyAPI.LanguageCode) {
        print(language)
        localeProvider.language = language.rawValue
        notificationCenter.post(LanguageChangeNotification(language:  language.rawValue))
    }
    
    func changeCountry(country: ShopifyAPI.CountryCode) {
        localeProvider.country = country.rawValue
        notificationCenter.post(CountryChangeNotification(country: country.rawValue))
    }
}
