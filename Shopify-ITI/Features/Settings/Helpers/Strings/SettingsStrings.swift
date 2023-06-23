//
//  SettingsStrings.swift
//  Shopify-ITI
//
//  Created by ammar on 24/06/2023.
//

import Foundation
protocol AnySettingsStrings {
    var languageLabel: String {get}
    var countryLabel: String {get}
    var helpCenterLabel: String {get}
    var addressLabel: String {get}
    var selectLanguageText : String {get}
    var selectCountryText : String {get}
    var fQAText : String {get}
    var contactUsText : String {get}
    var logoutText : String {get}
    var logoutAlertMessage : String {get}
    var agreeAlertMessage : String {get}
    var diagreeAlertMessage : String {get}
}
// TODO: localize
struct SettingsStrings: AnySettingsStrings, AnyInjectable  {
    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnySettingsStrings).self) { resolver in
            SettingsStrings()
        }
    }
   
    let languageLabel: String = "SettingsStrings.languageLabel"
    let countryLabel: String = "SettingsStrings.countryLabel"
    let helpCenterLabel: String = "SettingsStrings.helpCenterLabel"
    let addressLabel: String = "SettingsStrings.addressLabel"
    let selectLanguageText : String = "SettingsStrings.selectLanguageText"
    let selectCountryText : String = "SettingsStrings.selectCountryText"
    let fQAText : String = "SettingsStrings.fQAText"
    let contactUsText : String = "SettingsStrings.contactUsText"
    let logoutText : String = "SettingsStrings.logoutText"
    let logoutAlertMessage : String = "SettingsStrings.logoutAlertMessage"
    let agreeAlertMessage : String = "SettingsStrings.agreeAlertMessage"
    let diagreeAlertMessage : String = "SettingsStrings.diagreeAlertMessage"
}
