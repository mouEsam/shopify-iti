//
//  ProductsScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation
import SwiftUI

struct ProductsScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer, criterion: ProductsViewModel.Criterion) {
            self.init(identifier: String(describing: Self.self)) {
                ProductsScreen(container: container, criterion: criterion)
            }
        }
    }
    
    @EnvironmentObject private var container: AppContainer

    @StateObject private var viewModel: ProductsViewModel
    
    init(container: AppContainer, criterion: ProductsViewModel.Criterion) {
        let model = container.require((any AnyProductsModelFactory).self).create()
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _viewModel = .init(wrappedValue: ProductsViewModel(criterion: criterion,
                                                           model: model,
                                                           wishlistManager: manager,
                                                           notificationCenter: notificationCenter))
    }
    
    var body: some View {
        List {
            switch viewModel.uiState {
                case .loaded(let data):
                    let data = data.data
                    ForEach(data, id: \.id) { item in
                        Text(item.product.title)
                    }
                case .error(let error):
                    Text("\(error.localizedDescription)")
                case .loading:
                    ProgressView()
                default:
                    Group {}
            }
        }
        .onAppear {
            viewModel.fetch()
        }
        .padding()
        .onReceive(viewModel.$uiState) { state in
            print(state)
            print(state.data)
        }
        .onReceive(viewModel.$operationState) { state in
            print(state)
        }
    }
}
