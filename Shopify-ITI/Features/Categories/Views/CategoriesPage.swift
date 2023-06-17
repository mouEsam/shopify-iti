//
//  Categories.swift
//  Shopify-ITI
//
//  Created by ammar on 10/06/2023.
//

import SwiftUI

struct CategoriesPage: View {
    @EnvironmentObject private var container: AppContainer

    @StateObject private var viewModel:  CategoriesViewModel
    
    @State private var CollectionTypePicked = 0
    
    init(container: AppContainer) {
        let client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        let localeProvider = LocaleProvider()
        let model = container.require((any AnyCategoriesModelFactory).self).create()
        _viewModel = .init(wrappedValue:CategoriesViewModel(model: model))
    }
    
    let arr = [CollectionType.men,
               CollectionType.women,
               CollectionType.kid,
               CollectionType.sale
    ]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Picker("", selection: $CollectionTypePicked) {
                        ForEach(arr.indices){index in
                            Text(arr[index].rawValue).tag(index)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: CollectionTypePicked){newValue in
                        Task{
                            await viewModel.loadCategories(CollectionName: arr[newValue].apiHandle)
                        }
                    }
                    
                    switch viewModel.operationState {
                        
                    case .loaded(data: let productCollections):
                        LazyVGrid(columns: createGridColumns(), spacing: 16) {
                            ForEach(productCollections.data,id: \.id) { item in
                                CardCategory(title: item.productType.lowercased())
                            }
                        }
                        .padding()
                        
                    case .error(let error):
                        Text("Error: \(error.localizedDescription)")
                        
                    default :
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .foregroundColor(.black)
                            .padding(50)
                    }
                }
                
            }.task{
                await viewModel.loadCategories(CollectionName: arr[CollectionTypePicked].apiHandle)
            }
            
        }
    }
}
func createGridColumns() -> [GridItem] {
    let gridItem = GridItem(.flexible(), spacing: 16)
    return [gridItem, gridItem]
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


