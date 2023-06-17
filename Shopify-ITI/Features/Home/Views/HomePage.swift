//
//  HomePage.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    
    @StateObject private var viewModel:  BrandViewModel
    
    init(container: AppContainer) {
        let model = container.require((any AnyBrandModelFactory).self).create()
        _viewModel = .init(wrappedValue:BrandViewModel(model: model))
    }
    
    
    var body: some View {
        ScrollView{
            VStack {
                ADSView().aspectRatio(1,contentMode: .fit)
                Text("Brands").font(.largeTitle).fontWeight(.bold) // TODO: nameriztion
                
                switch viewModel.operationState {
                    
                case .loaded(data: let productCollections):
                    LazyVGrid(columns: createGridColumns(), spacing: 16) {
                        ForEach(productCollections.data,id: \.id) { item in
                            CardBrand(item:item)
                        }
                    }
                    .padding()
                    
                case .error(let error):
                    Text("Error: \(error.localizedDescription)")
                    
                default :
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.black)
                        .padding()
                }
            }
        }
    
        .toolbar {
            
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
                        FavouriteView()
                    }))
                }) {
                    Image(systemName: "heart")
                }
                
            }
            )
        }
        .onReceive(viewModel.$operationState){ state in
            print(state)
        }
        .onFirstTask {
            await viewModel.loadBrand(numberOfItem: 11)
        }
        
        
        
        
        
        
        
    }
    
    func createGridColumns() -> [GridItem] {
        let gridItem = GridItem(.flexible(), spacing: 16)
        return [gridItem, gridItem]
    }
    
    
    
}





