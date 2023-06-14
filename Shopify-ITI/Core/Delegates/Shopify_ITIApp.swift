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
        AdminEnvironmentProvider.self,
        UserLocalStore.self,
        GuestLocalStore.self,
        TokenLocalStore.self,
        WishlistIdStore.self,
        UserManager.self,
        GuestManager.self,
        TokenManager.self,
        AccessTokenHolder.self,
        UserHolder.self,
        AuthenticationManager.self,
        WishlistManager.self,
        AuthenticationRemoteService.self,
        ProfileRemoteService.self,
        WishlistRemoteService.self,
        AuthenticationRepository.self,
        WishlistModelFactory.self,
    ])
    
    var body: some View {
        NavigationView {
//            WishlistScreen(container: container)
            MainScreen()
        }
        .environmentObject(container)
    }
}
