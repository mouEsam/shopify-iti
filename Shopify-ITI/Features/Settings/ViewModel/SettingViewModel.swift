//
//  SettingViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
class SettingViewModel{
    let settingModel:SettingModel
    init(settingModel: SettingModel) {
        self.settingModel = settingModel
    }
    func changeLanguageToEnglish(){
        settingModel.changelanguage(language: .english)
    }
    func changeLanguageToArabic(){
        settingModel.changelanguage(language: .arabic)
    }
    func changeContryToUSA(){
        settingModel.changeCurrency(currency: .usa)
    }
    func changeContryToEgypt(){
        settingModel.changeCurrency(currency: .egypt)
    }
}
