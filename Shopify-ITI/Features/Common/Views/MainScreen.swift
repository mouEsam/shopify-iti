//
//  ContentView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 04/06/2023.
//

import SwiftUI

enum TabType{
    case home
    case categories
    case cart
    case profile
}

struct MainScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer) {
            self.init(identifier: String(describing: Self.self)) {
                MainScreen(container: container)
            }
        }
    }
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    @StateObject private var viewModel: MainScreenViewModel
    @State var selection: TabType = .home
    
    private let colors: any AnyAppColors
    
    init(container: AppContainer) {
        let cartManager = container.require(CartManager.self)
        let wishlistManager = container.require(WishlistManager.self)
        colors = container.require((any AnyAppColors).self)
        _viewModel = .init(wrappedValue: .init(wishlistManager: wishlistManager,
                                               cartManager: cartManager))
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomePage(container: container)
                .tabItem {
                    TabBarItemView(systemName: "house")
                }.tag(TabType.home)
            
            CategoriesPage(container: container)
                .tabItem {
                    TabBarItemView(systemName: "list.bullet")
                }
            CartView(container: container)
                .tabItem {
                    TabBarItemView(systemName: "cart")
                    
                }.badge(viewModel.cartCount ?? 0)
                .tag(TabType.cart)
            
            ProfilePage(container: container)
                .tag(TabType.profile)
                .tabItem {
                    TabBarItemView(systemName: "person")
                }
            
        } .toolbar {
            if(selection == TabType.profile){
                ToolbarItem( placement: .navigationBarTrailing) {
                    SwiftUI.Button(action: {
                        router.push(AppRoute(identifier:TabType.profile, content: {
                            SettingsView(container: container)
                        }
                                            ))
                    }) {
                        Image(systemName: "gearshape")
                    }
                }
            } else {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        router.push(AppRoute(identifier:TabType.cart, content: {
                            SearchView(container: container)
                        }))
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                }
                
                ToolbarItem( placement: .navigationBarTrailing) {
                    Button(action: {
                        router.push(AppRoute(identifier:TabType.home, content: {
                            WishlistScreen(container: container)
                        }))
                    }) {
                        let wishlistCount = viewModel.wishlistCount ?? 0
                        Image(systemName: wishlistCount > 0 ? "heart.fill" : "heart")
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        .tint(colors.black)
    }
}


fileprivate struct TabBarItemView: View {
    let systemName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                
            
        }
    }
}
