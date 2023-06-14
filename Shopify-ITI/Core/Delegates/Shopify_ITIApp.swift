//
//  Shopify_ITIApp.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 04/06/2023.
//

import SwiftUI

@main
struct Shopify_ITIApp: App {
    
    var body: some Scene {
        WindowGroup {

            RootView()
        }
    }
}

struct RootView: View {
    @StateObject private var container: AppContainer = AppContainer(injectables: [
        UserDefaults.self,
        NotificationCenter.self,
        KeysProvider.self,
        KeyChain.self,
        ConfigsProvider.self,
        LocaleProvider.self,
        JsonCoder.self,
        ApolloGraphQLClient.self,
        StorefronEnvironmentProvider.self,
        UserLocalStore.self,
        GuestLocalStore.self,
        TokenLocalStore.self,
        UserManager.self,
        GuestManager.self,
        TokenManager.self,
        AccessTokenHolder.self,
        UserHolder.self,
        AuthenticationManager.self,
        AuthenticationRemoteService.self,
        ProfileRemoteService.self,
        AuthenticationRepository.self,
        CartModel.self,
        CartRemoteService.self,
        CartManager.self,
        CartChecker.self
    ])
    
    var body: some View {
        NavigationView {
            LoginScreen(container: container)
        }
        .environmentObject(container)
    }
}
