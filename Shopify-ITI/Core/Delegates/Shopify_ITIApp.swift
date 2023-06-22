//
//  Shopify_ITIApp.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 04/06/2023.
//

import SwiftUI
import LanguageManagerSwiftUI

@main
struct Shopify_ITIApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    @StateObject private var container: AppContainer = AppContainer.production()
    
    var body: some View {
        LanguageManagerView(.deviceLanguage) {
            RouterView(router: AppRouter()) {
                SplashScreen(container: container)
            }
            .tint(.accentColor)
            .environmentObject(container)
        }
    }
}
