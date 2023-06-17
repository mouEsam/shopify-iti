//
//  ContentView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 04/06/2023.
//

import SwiftUI

struct MainScreen: View {
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    @State var badgeCount = 1
    var body: some View {
        TabView {
            
            HomePage(container: container)
                .tabItem {
                    TabBarItemView(systemName: "house")
                }
            
            CategoriesPage(container: container)
                .tabItem {
                    TabBarItemView(systemName: "list.bullet")
                }
            CartView(container: container)
                .tabItem {
                    TabBarItemView(systemName: "cart")
                    
                }.badge(badgeCount)
            ProfilePage(container: container)
                .tabItem {
                    TabBarItemView(systemName: "person")
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
