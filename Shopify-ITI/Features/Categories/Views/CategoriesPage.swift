//
//  Categories.swift
//  Shopify-ITI
//
//  Created by ammar on 10/06/2023.
//

import SwiftUI

struct CategoriesPage: View {
    var body: some View {
        NavigationView {
            Text("Categories View ")
                .navigationBarItems(
                    leading: NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }, trailing:
                        HStack {
                           
                            NavigationLink(destination: FavouriteView()) {
                                Image(systemName: "heart")
                            }
                        }
                )
            
        }
    }
}

struct Categories_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesPage()
    }
}
struct SearchView: View {
    var body: some View {
        Text("SearchView")
            .font(.largeTitle)
    }
}
struct SettingView: View {
    var body: some View {
        Text("SettingView")
            .font(.largeTitle)
    }
}
struct FavouriteView: View {
    var body: some View {
        Text("Fav View ")
    }
}
struct CartView: View {
    var body: some View {
        NavigationView {
            Text("Cart View ")
                .navigationBarItems(
                    leading: NavigationLink(destination: SearchView()) {
                        Image(systemName: "magnifyingglass")
                    }, trailing:
                        HStack {
                           
                            NavigationLink(destination: FavouriteView()) {
                                Image(systemName: "heart")
                            }
                        }
                )
            
        }
    }
}
