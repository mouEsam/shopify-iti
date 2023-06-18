//
//  SettingsView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedLanguageIndex = 0
    @State private var selectedCurrencyIndex = 0
    
    @State private var address = ""
    @State private var showFQA = false
    @State private var showContact = false
    let settingViewModel:SettingViewModel
    let languages = ["English", "Arabic"]
    let contry = ["Egypt","USA"]
    init(container:AppContainer){
        settingViewModel = .init(settingModel: container.require(SettingModel.self))
    }
    var body: some View {
        Form {
            Section(header: Text("Language")) {
                Picker(selection: $selectedLanguageIndex, label: Text("Select a language")) {
                    ForEach(0 ..< languages.count) { index in
                        Text(self.languages[index])
                    }
                }
                .onChange(of: selectedLanguageIndex) { newIndex in
                    let selectedLanguage = languages[newIndex]
                    if(selectedLanguage == "English" ){
                        settingViewModel.changeLanguageToEnglish()
                    }else{
                        settingViewModel.changeLanguageToArabic()
                        
                    }
                }
            }
            Section(header: Text("contry")) {
                Picker(selection:$selectedCurrencyIndex, label: Text("Select a contry")) {
                    ForEach(0 ..< contry.count) { index in
                        Text(self.contry[index])
                    }
                }.onChange(of: selectedCurrencyIndex) { newIndex in
                    let selectedCurrency = contry[newIndex]
                    if(selectedCurrency == "EGP" ){
                        settingViewModel.changeContryToEgypt()
                    }else{
                        settingViewModel.changeContryToUSA()
                        
                    }
                }
            }
            Section(header: Text("Help Center")) {
                Button(action: {
                    showFQA = true
                }) {
                    HStack{
                        Text("FQA")
                            .foregroundColor(.black)
                        
                    }
                }
                
                Button(action: {
                    showContact = true
                }) {
                    Text("Contact Us")
                        .foregroundColor(.black)
                }
            }
            
        }
        
        .sheet(isPresented: $showFQA) {
            FAQView()
        }.sheet(isPresented:  $showContact){
            ContactUsView()
            
        }
    }
}


