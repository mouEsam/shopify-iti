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
                         languageStore: resolver.require((any AnyLanguageLocalStore).self),
                         countryStore: resolver.require((any AnyCountryLocalStore).self),
                         notificationCenter: resolver.require((any AnyNotificationCenter).self),
                         localeProvider: resolver.require( LocaleProvider.self))
            
        }
    }
    
    private let remoteService: LocalizationRemoteService
    private let languageStore: any AnyLanguageLocalStore
    private let countryStore: any AnyCountryLocalStore
    private let notificationCenter :any AnyNotificationCenter
    private let localeProvider:LocaleProvider
    
    func fetch() async -> Result<SourcedData<Localization>, ShopifyErrors<Any>> {
        let result = await remoteService.fetch()
        return result.map { .remote($0) }
    }
    
    func getLanguage() -> ShopifyAPI.LanguageCode {
        if case .success(let language) = languageStore.read(),
           let language = ShopifyAPI.LanguageCode(rawValue: language) {
            return language
        } else {
            return .ar
        }
    }
    
    func getCountry() -> ShopifyAPI.CountryCode {
        if case .success(let country) = countryStore.read(),
           let country = ShopifyAPI.CountryCode(rawValue: country) {
            return country
        } else {
            return .eg
        }
    }
    
    func changelanguage(language: ShopifyAPI.LanguageCode) {
        languageStore.write(language: language.rawValue.lowercased())
        localeProvider.changeLanguage(language: language.rawValue)
        notificationCenter.post(LanguageChangeNotification(language:  language.rawValue))
    }
    
    func changeCountry(country: ShopifyAPI.CountryCode) {
        if case .success(_) = countryStore.write(country: country.rawValue) {
            localeProvider.changeCountry(country: country.rawValue)
            notificationCenter.post(CountryChangeNotification(country: country.rawValue))
        }
    }
}
