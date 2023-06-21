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
    
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    @StateObject private var viewModel: ProductsViewModel
    private var colors: AnyAppColors
    private var strings: AnyProductsStrings
    
    init(container: AppContainer,
         criterion: ProductsViewModel.Criterion) {
        colors = container.require((any AnyAppColors).self)
        strings = container.require((any AnyProductsStrings).self)
        let model = container.require((any AnyProductsModel).self)
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _viewModel = .init(wrappedValue: ProductsViewModel(criterion: criterion,
                                                           model: model,
                                                           wishlistManager: manager,
                                                           notificationCenter: notificationCenter))
    }
    
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .loaded(let data):
                    let data = data.data
                    if data.isEmpty {
                        NoResultsView(message: strings.noProductsLabel.localized)
                    } else {
                        GeometryReader { geometryProxy in
                            ScrollView {
                                LazyVGrid(columns: createGridItems(geometryProxy.size.width),
                                          alignment: .center,
                                          spacing: 10) {
                                    ForEach(data) { item in
                                        ProductItemView(container: container,
                                                        product: item.product,
                                                        isWishlisted: item.isWishlisted) {
                                            let result = await viewModel.toggleWishlist(item: item.product)
                                            await MainActor.run {
                                                if case .failure(let error) = result {
                                                    router.alert(item: ErrorWrapper(error: error)) { wrapper in
                                                        Alert(title: Text(strings.wishlistErrorLabel.localized),
                                                              message: Text(wrapper.error.localizedDescription))
                                                    }
                                                }
                                            }
                                        }
                                        .aspectRatio(0.6, contentMode: .fill)
                                    }
                                }
                                .padding(.horizontal, 10)
                                
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
                            }
                        }
                    }
                case .error(let error):
                    ErrorMessageView(message: "\(error.localizedDescription)")
                default:
                    ProgressView()
            }
        }
        .background(colors.white)
        .foregroundColor(colors.black)
        .onFirstAppear {
            viewModel.initialize()
        }
    }
    
    private func createGridItems(_ width: Double) -> [GridItem] {
        let roughCount = width / 150
        let count = Int(floor(roughCount))
        let columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 200, maximum: 250),
                                                         spacing: 10,
                                                         alignment: .center),
                                        count: count)
        return columns
    }
}

struct ProductsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProductsScreen(container: AppContainer.preview(), criterion: [:])
    }
}
