//
//  SettingsView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    @StateObject private var settingViewModel:SettingViewModel
    
    private let colors: AnyAppColors
    
    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        let authManager = container.require(AuthenticationManager.self)
        _settingViewModel = .init(wrappedValue: SettingViewModel(authManager: authManager,
                                                                 settingModel: container.require(SettingsModel.self)))
    }
    
    var body: some View {
        
        Form {
            // TODO: localize
            let languages = settingViewModel.uiState.data?.languages ?? [settingViewModel.langauge]
            Section(header: Text("Language")) {
                Picker(selection: $settingViewModel.langauge, label: Text("Select a language")) {
                    ForEach(languages) { language in
                        Text(language.localizationKey.localized).tag(language)
                    }
                }
                .onChange(of: settingViewModel.langauge) { newLanguage in
                    settingViewModel.change(language: newLanguage)
                }
            }
            let countries = settingViewModel.uiState.data?.countries ?? [settingViewModel.country]
            Section(header: Text("Country")) {
                Picker(selection: $settingViewModel.country, label: Text("Select a contry")) {
                    ForEach(countries) { country in
                        Text(country.localizationKey.localized).tag(country)
                    }
                }
                .onChange(of: settingViewModel.country) { newCountry in
                    settingViewModel.change(country: newCountry)
                }
            }
            Section(header: Text("Help Center")) {
                Button(action: {
                    router.present(.sheet) {
                        FAQView()
                    }
                }) {
                    HStack{
                        Text("FQA")
                            .foregroundColor(colors.black)
                    }
                }
                
                Button(action: {
                    router.present(.sheet) {
                        ContactUsView()
                    }
                }) {
                    Text("Contact Us")
                        .foregroundColor(colors.black)
                }
            }
            if settingViewModel.isLoggedIn {
                Button(action: {
                    router.alert(item: IdentifiableWrapper(wrapped: settingViewModel.logoutState)) { _ in
                        Alert(title: Text("Logout"),
                              message: Text("Are you sure you want to logout ?"),
                              primaryButton: Alert.Button.default(Text("No")),
                              secondaryButton: Alert.Button.destructive(Text("Yes"), action: {
                            settingViewModel.logout()
                        }))
                    }
                }) {
                    HStack {
                        Text("Log out")
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
