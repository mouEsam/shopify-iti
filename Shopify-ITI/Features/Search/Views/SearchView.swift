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
    @StateObject private var viewModel: SearchViewModel
    
    private var colors: AnyAppColors
    private var strings: AnySearchStrings
    
    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        strings = container.require((any AnySearchStrings).self)
        let model = container.require((any AnySearchModel).self)
        _viewModel = .init(wrappedValue: SearchViewModel(model: model))
    }
    
    private var searchResults: [String] {
        let suggestions = viewModel.suggestions
        var searchResults = viewModel.uiState.data ?? []
        if case .initial = viewModel.uiState {
            searchResults = suggestions
        }
        return searchResults
    }
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { name in
                Button(action: {
                    router.push(ProductsScreen.Route(container: container,
                                                     criterion: [.query:name]))
                }) {
                    Text(name)
                }
            }
        }
        .background(colors.white)
        .foregroundColor(colors.black)
        .searchable(text: $viewModel.input,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: strings.searchHint.localized)
        .onSubmit(of: .search)  {
            if !viewModel.input.isEmpty {
                viewModel.onSearch()
                router.push(ProductsScreen.Route(container: container,
                                                 criterion: [.query: viewModel.input]))
            }
        }
    }
}
