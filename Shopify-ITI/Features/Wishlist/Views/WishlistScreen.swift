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
                            Text("Empty") // TODO: Localize
                        } else {
                            List {
                                ForEach(data) { item in
                                    WishlistItemView(product: item.product) {
                                        let result = await viewModel.remove(item: item)
                                        await MainActor.run {
                                            if case .failure(let error) = result {
                                                router.alert(item: ErrorWrapper(error: error)) { wrapper in
                                                    Alert(title: Text("Error"), // TODO: localize
                                                          message: Text(wrapper.error.localizedDescription))
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
                    Text("\(error.localizedDescription)")
                default:
                    ProgressView().foregroundColor(.black)
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
