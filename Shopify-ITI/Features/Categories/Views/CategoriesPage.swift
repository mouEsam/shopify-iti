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
    
    @State private var collectionTypePicked = 0
    
    private let strings : AnyCategoriesStrings
    private let colors : AnyAppColors
    
    init(container: AppContainer) {
        
        let model = container.require((any AnyCategoriesModelFactory).self).create()
        _viewModel = .init(wrappedValue:CategoriesViewModel(model: model))
        
        strings = container.require((any AnyCategoriesStrings).self)
        colors = container.require((any AnyAppColors).self)
    }
    
    
    let itemOfSegmented = [CollectionType.men,
                           CollectionType.women,
                           CollectionType.kid,
                           CollectionType.sale
    ]
    
    var body: some View {
        VStack{
            Picker("", selection: $collectionTypePicked) {
                ForEach(itemOfSegmented.indices){index in
                    Text(itemOfSegmented[index].localizedString(using: strings)).tag(index).foregroundColor(colors.black)
                }
            }
            .pickerStyle(.segmented)
            
            .padding()
            .onChange(of: collectionTypePicked){newValue in
                Task{
                    await viewModel.loadCategories(CollectionName: itemOfSegmented[newValue].apiHandle)
                }
            }
            
            
            switch viewModel.operationState {
                
            case .loaded(data: let productCollections):
                LazyVGrid(columns: createGridColumns(), spacing: 16) {
                    ForEach(productCollections.data,id: \.id) { item in
                        CardCategory(item: item, idOfCollection: itemOfSegmented[collectionTypePicked].apiID)
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
            
        }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        .task{
            
            await viewModel.loadCategories(CollectionName: itemOfSegmented[collectionTypePicked].apiHandle)
        }.onFirstTask {
            await viewModel.loadCategories(CollectionName: itemOfSegmented[collectionTypePicked].apiHandle)
        }
    }
}


private func createGridColumns() -> [GridItem] {
    let gridItem = GridItem(.flexible(), spacing: 16)
    return [gridItem, gridItem]
}



