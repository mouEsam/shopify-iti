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
    
    let colors : AnyAppColors
    
    @StateObject private var viewModel:  SearchViewModel
    @State private var searchText = ""
    
    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        
        _viewModel = .init(wrappedValue: SearchViewModel())
    }
    
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
                viewModel.addFavorite(searchText)
                router.push(ProductsScreen.Route(container: container,
                                                 criterion: [.title:searchText]))
            }
        }
        .onFirstAppear () {
            viewModel.retrieveFavorites()
            
        }
        
    }
    
    var searchResults: [String]{
        if searchText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { $0.contains(searchText) }
        }
    }
    
 
}
