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
    
    @State var selection:TabType = .home
    
    private let cartManager : CartManager
    
    init(container: AppContainer) {
        cartManager = container.require(CartManager.self)
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
                    
                }.badge(cartManager.state.data?.cartLine.count ?? 0)
                .tag(TabType.cart)
            
            ProfilePage(container: container)
                .tag(TabType.profile)
                .tabItem {
                    TabBarItemView(systemName: "person")
                }
            
        } .toolbar {
            if(selection == TabType.profile){
                ToolbarItem( placement: .navigationBarTrailing) {
                    Button(action: {
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
                        Image(systemName: "heart")
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
}


fileprivate struct TabBarItemView: View {
    let systemName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .foregroundColor(.black)
            
        }
    }
}
