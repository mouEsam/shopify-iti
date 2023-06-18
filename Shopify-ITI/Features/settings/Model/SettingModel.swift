//
//  SettingModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
struct SettingModel:AnyInjectable{
    static func register(_ container: AppContainer) {
        container.register(type: SettingModel.self){resolver in
            SettingModel(notificationCenter: resolver.require((any AnyNotificationCenter).self),localeProvider: resolver.require( LocaleProvider.self))

        }
    }
    let notificationCenter :any AnyNotificationCenter
    let localeProvider:LocaleProvider
    func changelanguage(language:Language){
        UserDefaults.standard.set([language.phonelocal], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()
        localeProvider.changeLanguage(language: language.rawValue)
        notificationCenter.post(LanguageChangeNotification(language:  language.rawValue))
    }
    func changeCurrency(currency:Country){
        localeProvider.changeCountry(country:currency.rawValue )
        notificationCenter.post(CurrencyChangeNotification(currency: currency.rawValue))
    }
}
