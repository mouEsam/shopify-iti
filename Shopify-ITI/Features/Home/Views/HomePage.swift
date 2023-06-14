//
//  HomePage.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import SwiftUI

struct HomePage: View {
    
    @StateObject private var viewModel:  BrandViewModel
    init() {
        let client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
        let localeProvider = LocaleProvider()
        
        _viewModel = .init(wrappedValue:BrandViewModel(model:  BrandModel(remoteService: BrandRemoteService(remoteClient: client, localeProvider: localeProvider))))
        
       
        
    }
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    
                    ADSView().aspectRatio(1,contentMode: .fit)
                    Text("Brands").font(.largeTitle).fontWeight(.bold) // TODO : nameriztion
                    
                        switch viewModel.operationState {


                        case .loaded(data: let productCollections):
                            LazyVGrid(columns: createGridColumns(), spacing: 16) {
                                ForEach(productCollections.data,id: \.id) { item in
                                    
                                    CardBrand(imageName: item.image?.url ?? "", title: item.title)
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
                
                
            }.navigationBarItems(
                leading: NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass")
                }, trailing:
                    HStack {
                        
                        NavigationLink(destination: FavouriteView()) {
                            Image(systemName: "heart")
                        }
                    }
            ).onReceive(viewModel.$operationState){ state in
                print(state)
            }
            .onFirstTask {
                await viewModel.loadBrand(numberOfItem: 11)
            }
            
            
            
            
            
        }
        
    }
    
    func createGridColumns() -> [GridItem] {
        let gridItem = GridItem(.flexible(), spacing: 16)
        return [gridItem, gridItem]
    }
  
    
    
}



struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}

