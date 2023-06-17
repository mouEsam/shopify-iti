//
//  SettingsView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedLanguageIndex = 0
    @State private var address = ""
    @State private var showFQA = false
    @State private var showContact = false

    let languages = ["English", "Spanish", "French"]
    
    var body: some View {
            Form {
                Section(header: Text("Language")) {
                    Picker(selection: $selectedLanguageIndex, label: Text("Select a language")) {
                        ForEach(0 ..< languages.count) { index in
                            Text(self.languages[index])
                        }
                    }
                }
                
                Section(header: Text("Address")) {
                    TextField("Enter your address", text: $address)
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
            HelpCenterView()
        }.sheet(isPresented:  $showContact){
            HelpCenterView()

        }
    }
}

struct HelpCenterView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("FAQ")) {
                    Text("Frequently Asked Questions")
                }
                
                Section(header: Text("Contact Us")) {
                    Text("You can reach us at support@example.com")
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Help Center")
        }
    }
}





struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
