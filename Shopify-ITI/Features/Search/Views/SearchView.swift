//
//  ADCard.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct SearchView: View {
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    let names = ["Rings", "jecket", "sweater"]
    @State private var searchText = ""
    
    var body: some View {
        
        List {
            ForEach(searchResults, id: \.self) { name in
                Button(action: {
                    router.push(ProductsScreen.Route(container: container,
                                                      criterion: [.title:name]))
                }) {
                    Text(name)
                }.foregroundColor(.black)
                
            }
        }
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always),prompt: "search for product")//TODO: nemoriztion
        .onSubmit(of: .search)  {
            if !searchText.isEmpty {
                router.push(ProductsScreen.Route(container: container,
                                                 criterion: [.title:searchText]))
            }
        }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}
