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
    @AppStorage("suggestions") private var suggestions: [String]?
    @StateObject private var viewModel: SearchViewModel
    
    private var colors: AnyAppColors
    
    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        let model = container.require((any AnySearchModel).self)
        _viewModel = .init(wrappedValue: SearchViewModel(model: model))
    }
    
    private var searchResults: [String] {
        let suggestions = suggestions ?? []
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
                    prompt: "search for product") // TODO: nemoriztion
        .onSubmit(of: .search)  {
            if !viewModel.input.isEmpty {
                router.push(ProductsScreen.Route(container: container,
                                                 criterion: [.query: viewModel.input]))
                var suggestions = [viewModel.input]
                suggestions.append(contentsOf: self.suggestions ?? [])
                self.suggestions = suggestions
            }
        }
    }
}
