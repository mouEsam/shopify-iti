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
    
    private let notificationCenter : any AnyNotificationCenter
    private let strings : AnyHomeStrings
    private let colors : AnyAppColors
    
    private let topId = "TOP"
    
    init(container: AppContainer) {
        notificationCenter = container.require((any AnyNotificationCenter).self)
        let model = container.require((any AnyBrandModelFactory).self).create()
        _viewModel = .init(wrappedValue:BrandViewModel(model: model))

        strings = container.require((any AnyHomeStrings).self)
        colors = container.require((any AnyAppColors).self)
    }
    
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    ADSView()
                        .aspectRatio(1,contentMode: .fit)
                        .id(topId)
                    Text(strings.brandsLabel.localized)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(colors.black)
                    
                    switch viewModel.operationState {
                        case .loaded(data: let productCollections):
                            if(productCollections.data.isEmpty){
                                NoResultsView(message: strings.emptyListBrands)
                            }
                            else {
                                LazyVGrid(columns: createGridColumns(), spacing: 16) {
                                    ForEach(productCollections.data,id: \.id) { item in
                                        CardBrand(container: container,
                                                  item:item)
                                    }
                                }
                                .padding()
                            }
                        case .error(let error):
                                ErrorMessageView(error: error)
                        default :
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .padding()
                        }
                }
            }
            .onReceive(notificationCenter.publisher(for: PaymentNotification.name)) { _ in
                proxy.scrollTo(topId)
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





