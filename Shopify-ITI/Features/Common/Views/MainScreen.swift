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
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    @State var badgeCount = 1
    @State var selection:TabType = .home
    
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
                    
                }.badge(badgeCount).tag(TabType.cart)
            
            ProfilePage(container: container)
                .tag(TabType.profile)
                .tabItem {
                    TabBarItemView(systemName: "person")
                }
            
        } .toolbar {
            if(selection == TabType.profile){
                ToolbarItem( placement: .navigationBarTrailing, content: {
                    Button(action: {
                        
                        router.push(AppRoute(identifier:3, content: {
                           FavouriteView()
                        }
                                            ))
                    }) {
                        
                        Image(systemName: "gearshape")
                    }
                    
                }
                )
            }
            else{
                ToolbarItem( placement: .navigationBarLeading, content: {
                    Button(action: {
                        router.push(AppRoute(identifier:3, content: {
                            SearchView()
                        }))
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                })

                ToolbarItem( placement: .navigationBarTrailing, content: {
                    Button(action: {
                        router.push(AppRoute(identifier:3, content: {
                            WishlistScreen(container: container)
                        }))
                    }) {
                        Image(systemName: "heart")
                    }
                    
                }
                )
            }
           
        }.tint(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
struct TabBarItemView: View {
    let systemName: String
    
    var body: some View {
        VStack {
            Image(systemName: systemName)
                .foregroundColor(.black)
            
        }
    }
}
