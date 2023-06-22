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
    private var strings: AnyWishlistStrings
    
    init(container: AppContainer) {
        strings = container.require((any AnyWishlistStrings).self)
        let model = container.require((any AnyWishlistModel).self)
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
                            NoResultsView(message: strings.noProductsLabel) // TODO: Localize
                        } else {
                            List {
                                ForEach(data) { item in
                                    WishlistItemView(container: container,
                                                     product: item.product) {
                                        let result = await viewModel.remove(item: item)
                                        await MainActor.run {
                                            if case .failure(let error) = result {
                                                router.alert(item: ErrorWrapper(error: error)) { wrapper in
                                                    Alert(title: Text(strings.wishlistErrorLabel.localized),
                                                          message: wrapper.error.text)
                                                }
                                            }
                                        }
                                    }
                                }
                                if let hasNextCursor = viewModel.pageInfo?.hasNextCursor,
                                   hasNextCursor {
                                    let progressView = ProgressView()
                                        .frame(maxWidth: .infinity,
                                               alignment: .center)
                                    if !viewModel.operationState.isLoading {
                                        progressView.onFirstAppear {
                                            viewModel.fetch()
                                        }
                                    } else {
                                        progressView
                                    }
                                }
                            }.listStyle(.plain)
                        }
                    }
                case .error(let error):
                    ErrorMessageView(error: error)
                default:
                    ProgressView()
            }
        }
        .onFirstAppear {
            viewModel.initialize()
        }
    }
}

struct WishlistScreen_Previews: PreviewProvider {
    static var previews: some View {
        WishlistScreen(container: AppContainer.preview())
    }
}
