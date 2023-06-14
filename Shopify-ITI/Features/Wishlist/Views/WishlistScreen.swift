//
//  WishlistPage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import SwiftUI

struct WishlistScreen: View {
    
    @EnvironmentObject private var container: AppContainer

    @StateObject private var viewModel: WishlistViewModel
    
    init(container: AppContainer) {
        let model = container.require((any AnyWishlistModelFactory).self).create()
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _viewModel = .init(wrappedValue: WishlistViewModel(model: model,
                                                           wishlistManager: manager,
                                                           notificationCenter: notificationCenter))
    }
    
    var body: some View {
        List {
            switch viewModel.uiState {
                case .loaded(let data):
                    let data = data.data
                    ForEach(data, id: \.id) { item in
                        Text(item.name)
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
