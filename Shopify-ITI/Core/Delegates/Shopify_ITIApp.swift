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
        ProductRemoteService.self,
        ProductsRemoteService.self,
        BrandRemoteService.self,
        CategoriesRemoteService.self,
        AuthenticationRepository.self,
        WishlistModelFactory.self,
        ProductModelFactory.self,
        ProductsModelFactory.self,
        BrandModelFactory.self,
        CategoriesModelFactory.self,
        ProfileRepository.self,
        CartModel.self,
        CartRemoteService.self,
        CartManager.self,

        CartIdStore.self,
        WishlistModelFactory.self,
        AuthenticationStrings.self,
        AuthenticationColors.self,
        SettingModel.self
    ])
    
    var body: some View {
       RouterView(router: AppRouter()) {
            MainScreen(container: container)
        }
        .environmentObject(container)
    }
}

struct AppView: View {
    
    @EnvironmentRouter private var router: AppRouter
    
    var body: some View {
        List {
            HStack {
                ForEach(Range(0...2)) { index in
                    Button(action: {
                        router.push(AppRoute(identifier: index, content: {
                            AnotherAppView(index: index)
                        }))
                    }) {
                        Text("Simple \(index)").foregroundColor(.white).padding().background(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            ForEach(Range(0...2)) { index in
                Button(action: {
                    router.push(AppRoute(identifier: index, content: {
                        AppView()
                    }))
                }) {
                    Text("Nav \(index)").foregroundColor(.white).padding().background(RoundedRectangle(cornerRadius: 8))
                }
            }
            ForEach(Range(0...2)) { index in
                Button(action: {
                    router.push(CustomRoute(identifier: index, content: {
                        CustomAppView(index: index)
                    }))
                }) {
                    Text("Custom \(index)").foregroundColor(.white).padding().background(RoundedRectangle(cornerRadius: 8))
                }
            }
            ForEach([Overlay.fullscreen, Overlay.popover, Overlay.sheet]) { overlay in
                Button(action: {
                    router.present(overlay) {
                        AppOverlayView(index: overlay)
                    }
                }) {
                    Text("Overlay \(overlay.rawValue)").foregroundColor(.white).padding().background(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
}

// Routes
struct AnotherAppView: View {
    
    @EnvironmentRoute private var route: AppRoute
    @EnvironmentRouter private var router: AppRouter
    
    private let index: Int
    
    init(index: Int) {
        self.index = index
    }
    
    var body: some View {
        Text("\(index) \(route.hashValue)")
    }
}

// Custom routs
class CustomRoute: AppRoute {
}

struct CustomAppView: View {
    
    @EnvironmentRoute private var route: CustomRoute
    @EnvironmentRouter private var router: AppRouter
    
    private let index: Int
    
    init(index: Int) {
        self.index = index
    }
    
    var body: some View {
        Text("\(index) \(route.hashValue)")
    }
}

// Overlays
struct AppOverlayView: View {
    
    @EnvironmentOverlayRoute private var route: AppOverlayRoute
    @EnvironmentRouter private var router: AppRouter
    
    private let index: Overlay
    
    init(index: Overlay) {
        self.index = index
    }
    
    var body: some View {
        VStack {
            Text("\(index.rawValue) \(route.hashValue)")
            Button(action: {
                router.dismiss()
            }) {
                Text("Back").foregroundColor(.white).padding().background(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}
