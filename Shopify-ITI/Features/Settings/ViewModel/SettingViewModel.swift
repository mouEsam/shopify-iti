//
//  SettingViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
import Shopify_ITI_SDK

class SettingViewModel: ObservableObject {
    
    @Published private(set) var uiState: UIState<Localization> = .initial
    @Published var langauge: ShopifyAPI.LanguageCode
    @Published var country: ShopifyAPI.CountryCode
    
    private let settingModel: SettingsModel
    
    init(settingModel: SettingsModel) {
        self.settingModel = settingModel
        langauge = settingModel.getLanguage()
        country = settingModel.getCountry()
    }
    
    private func update() {
        langauge = settingModel.getLanguage()
        country = settingModel.getCountry()
    }
    
    func fetch() async {
        await MainActor.run {
            uiState = .loading
        }
        let result = await settingModel.fetch()
        await MainActor.run {
            switch result {
                case .success(let data):
                    uiState = .loaded(data: data)
                    syncValues(data.data)
                    return
                case .failure(let error):
                    uiState = .error(error: error)
                    return
            }
        }
    }
    
    func change(language: ShopifyAPI.LanguageCode) {
        settingModel.changelanguage(language: language)
        self.update()
    }
    
    func change(country: ShopifyAPI.CountryCode) {
        settingModel.changeCountry(country: country)
        self.update()
    }
    
    private func syncValues(_ localizations: Localization) {
        if !localizations.languages.contains(where: { lang in lang == langauge }),
           let language = localizations.languages.first {
            settingModel.changelanguage(language: language)
        }
        if !localizations.countries.contains(where: { con in con == country }),
           let country = localizations.countries.first {
            settingModel.changeCountry(country: country)
        }
        self.update()
    }
}
