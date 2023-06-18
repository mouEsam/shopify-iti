//
//  WishlistPage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import SwiftUI

struct WishlistScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer) {
            self.init(identifier: String(describing: Self.self)) {
                WishlistScreen(container: container)
            }
        }
    }
    
    @EnvironmentRouter private var router: AppRouter
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
        Group {
            switch viewModel.uiState {
                case .loaded(let data):
                    Group {
                        let data = data.data
                        if data.isEmpty {
                            Text("Empty")
                        } else {
                            List(data) { item in
                                WishlistItemView(product: item.product)
                            }.listStyle(.plain)
                            if let hasNextCursor = viewModel.pageInfo?.hasNextCursor,
                               hasNextCursor {
                                ProgressView().onReceive(viewModel.$operationState) { state in
                                    if !state.isLoading {
                                        viewModel.fetch()
                                    }
                                }
                            }
                        }
                    }
                case .error(let error):
                    Text("\(error.localizedDescription)")
                case .loading:
                    ProgressView().foregroundColor(.black)
                default:
                    Group {}
            }
        }
        .onFirstAppear {
            viewModel.initialize()
        }
    }
}
