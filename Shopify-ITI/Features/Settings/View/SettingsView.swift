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
        _settingViewModel = .init(wrappedValue: SettingViewModel(settingModel: container.require(SettingsModel.self)))
    }
    
    var body: some View {
        Form {
            // TODO: localize
            let languages = settingViewModel.uiState.data?.languages ?? [settingViewModel.langauge]
            Section(header: Text("Language")) {
                Picker(selection: $settingViewModel.langauge, label: Text("Select a language")) {
                    ForEach(languages) { language in
                        Text(language.rawValue) // TODO: localize
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
                        Text(country.rawValue) // TODO: localize
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
            // TODO: change
            Button("Log out") {
                container.require(AuthenticationManager.self).logout()
            }
        }
        .onFirstTask {
            await settingViewModel.fetch()
        }
    }
}


