//
//  SettingsView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI
import LanguageManagerSwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var languageSettings: LanguageSettings
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    @StateObject private var settingViewModel:SettingViewModel
    
    private let colors: AnyAppColors
    private let strings: AnySettingsStrings
    
    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        strings = container.require((any AnySettingsStrings).self)
        let authManager = container.require(AuthenticationManager.self)
        _settingViewModel = .init(wrappedValue: SettingViewModel(authManager: authManager,
                                                                 settingModel: container.require(SettingsModel.self),
                                                                 addressManger: container.require(AddressManger.self)))
    }
    
    var body: some View {
        
        Form {
            let languages = settingViewModel.uiState.data?.languages ?? [settingViewModel.langauge]
            Section(header: Text(strings.languageLabel.localized)) {
                Picker(selection: $settingViewModel.langauge, label: Text(strings.selectLanguageText.localized)) {
                    ForEach(languages) { language in
                        Text(language.localizationKey.localized).tag(language)
                    }
                }
                .onChange(of: settingViewModel.langauge) { newLanguage in
                    router.alert(item: newLanguage) { _ in
                        Alert(title: Text("Language"),
                              message: Text("Some aspects of the app might not pick up the new language right away. We recommend you restart the app for a better experience"),
                              dismissButton: Alert.Button.default(Text("OK"), action: {
                            settingViewModel.change(language: newLanguage)
                            withAnimation {
                                let language: Languages = .init(rawValue: newLanguage.rawValue.lowercased()) ?? .deviceLanguage
                                languageSettings.selectedLanguage = language
                            }
                        }))
                    }
                }
            }
            let countries = settingViewModel.uiState.data?.countries ?? [settingViewModel.country]
            Section(header: Text(strings.countryLabel.localized)) {
                Picker(selection: $settingViewModel.country, label: Text(strings.selectCountryText.localized)) {
                    ForEach(countries) { country in
                        Text(country.localizationKey.localized).tag(country)
                    }
                }
                .onChange(of: settingViewModel.country) { newCountry in
                    settingViewModel.change(country: newCountry)
                }
            }
            Section(header: Text(strings.helpCenterLabel.localized)) {
                Button(action: {
                    router.present(.sheet) {
                        FAQView()
                    }
                }) {
                    HStack{
                        Text(strings.fQAText.localized)
                            .foregroundColor(colors.black)
                    }
                }
                
                Button(action: {
                    router.present(.sheet) {
                        ContactUsView()
                    }
                }) {
                    Text(strings.contactUsText.localized)
                        .foregroundColor(colors.black)
                }
            }
            if settingViewModel.isLoggedIn {
                Section(header: Text(strings.addressLabel.localized)){
                    
                    VStack(alignment: .leading) {
                        HStack{
                            Text(settingViewModel.address.street)
                                .font(.headline)
                            Spacer()
                            Button(action: {
                                router.push(AppRoute(identifier:  String(describing: LocationView.self)){
                                    LocationView(container: container)
                                    
                                })                            }) {
                                    Image("rightArrow").resizable().frame(width: 40,height: 40)
                                }
                        }
                    
                        
                        Text("\(settingViewModel.address.city), \(settingViewModel.address.state) \(settingViewModel.address.postalCode)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                Button(action: {
                    router.alert(item: IdentifiableWrapper(wrapped: settingViewModel.logoutState)) { _ in
                        Alert(title: Text(strings.logoutText.localized),
                              message: Text(strings.logoutAlertMessage.localized),
                              primaryButton: Alert.Button.default(Text(strings.diagreeAlertMessage.localized)),
                              secondaryButton: Alert.Button.destructive(Text(strings.agreeAlertMessage.localized), action: {
                            settingViewModel.logout()
                        }))
                    }
                }) {
                    HStack {
                        Text(strings.logoutText.localized)
                        if settingViewModel.logoutState.isLoading {
                            Spacer().frame(width: 10)
                            ProgressView()
                        }
                    }
                }
            }
        }
        .onFirstTask {
            await settingViewModel.fetch()
        }
    }
}
