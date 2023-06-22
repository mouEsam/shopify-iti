//
//  ProductPage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import SwiftUI

struct ProductPage: View {
    class Route: AppRoute {
        convenience init(container: AppContainer, productId: String) {
            self.init(identifier: String(describing: Self.self)) {
                ProductPage(container: container, productId: productId)
            }
        }
    }
    
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    @StateObject private var viewModel: ProductViewModel
    @Environment(\.layoutDirection) private var layoutDirection
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var currentImage = 0
    private var strings: AnyProductStrings
    
    private let colors: AnyAppColors
    
    init(container: AppContainer, productId: String) {
        colors = container.require((any AnyAppColors).self)
        strings = container.require((any AnyProductStrings).self)
        let model = container.require((any AnyProductModel).self)
        let manager = container.require(WishlistManager.self)
        let cartManager = container.require(CartManager.self)
        _viewModel = .init(wrappedValue: ProductViewModel(productId:productId,
                                                          model: model,
                                                          wishlistManager: manager,
                                                          cartManager: cartManager))
    }
    
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .loaded(let data):
                    let product = data.data
                    ScrollView {
                        TabView(selection: $currentImage) {
                            ForEach(product.images) { image in
                                RemoteImageView(image: image)
                            }
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(50, corners: layoutDirection == .leftToRight ? .bottomLeft : .bottomRight)
                        .shadow(radius: 4)
                        .padding(.leading, 40)
                        .tabViewStyle(.page(indexDisplayMode: .always))
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.title)
                                    .fontWeight(.medium)
                                HStack {
                                    PriceRangeView(priceRange: product.priceRange)
                                    .font(.title2)
                                    .fontWeight(.heavy)
                                    Spacer()
                                    HStack(spacing: 16) {
                                        Button(action: viewModel.increment) {
                                            Image("plus")
                                                .font(.title)
                                        }
                                        Text(String(viewModel.currentQuantity))
                                        Button(action: viewModel.decrement) {
                                            Image("minus")
                                                .font(.title)
                                        }
                                    }
                                }
                                Text(product.description)
                                    .font(.caption)
                                    .foregroundColor(colors.dark2Grey)
                            }
                            .padding(.leading, safeAreaInsets.leading)
                            .padding(.trailing, safeAreaInsets.trailing)
                            .padding(.horizontal, 24)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(product.variants) { variant in
                                        let isSelected = viewModel.selectedVariantId == variant.id
                                        VariantItemView(container: container,
                                                        variant: variant,
                                                        isSelected: isSelected) {
                                            viewModel.select(variant: variant)
                                        }
                                        .frame(height: 250)
                                        .aspectRatio(0.55, contentMode: .fit)
                                    }
                                }
                                .padding(.leading, safeAreaInsets.leading)
                                .padding(.trailing, safeAreaInsets.trailing)
                                .padding(24)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        Spacer().frame(height: 56)
                    }
                    .overlay(alignment: .bottom) {
                        HStack {
                            if let isWishlisted = viewModel.isWishlisted {
                                WishlistBag(isWishlisted: isWishlisted) {
                                    viewModel.toggleWishlist()
                                }.disabled(viewModel.wishlistState.isLoading)
                            }
                            RoundedButton(label: strings.addToCartLabel, // TODO: localize
                                          labelColor: colors.white,
                                          backgroundColor: colors.black,
                                          isLoading: viewModel.cartState.isLoading) {
                                viewModel.addToCart()
                            }.disabled(viewModel.cartState.isLoading)
                        }
                        .frame(maxHeight: 56)
                        .padding(.leading, safeAreaInsets.leading)
                        .padding(.trailing, safeAreaInsets.trailing)
                        .padding(.horizontal, 24)
                    }
                case .error(error: let error):
                    ErrorMessageView(error: error)
                default:
                    ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topLeading) {
            VStack {
                Button {
                    router.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                        .font(.headline)
                        .padding(4)
                        .frame(width: 32, height: 32)
                }
                .buttonStyle(.borderedProminent)
                .shadow(radius: 12)
                .foregroundColor(colors.black)
                .tint(colors.white)
                
                VStack {
                    Spacer()
                    VStack {
                    }.clipShape(Capsule())
                    Spacer()
                }.frame(width: 76)
            }
            .padding(.top, safeAreaInsets.top)
        }
        .frame(maxWidth: .infinity, maxHeight:.infinity)
        .edgesIgnoringSafeArea([.top, .horizontal])
        .toolbar(.hidden)
        .background(colors.white)
        .foregroundColor(colors.black)
        .onFirstTask {
            await viewModel.initialize()
        }
        .onReceive(viewModel.$cartError) { wrapper in
            if let wrapper = wrapper {
                router.alert(item: wrapper) { wrapper in
                    Alert(title: Text(strings.addToCartError.localized),
                          message: wrapper.error.text)
                }
            }
        }
        .onReceive(viewModel.$cartSuccess) { wrapper in
            if let wrapper = wrapper {
                router.alert(item: wrapper) { _ in
                    Alert(title: Text(strings.addToCartSuccess.localized),
                          message: Text(strings.addToCartSuccessMessage.localized))
                }
            }
        }
        .onReceive(viewModel.$wishlistError) { wrapper in
            if let wrapper = wrapper {
                router.alert(item: wrapper) { wrapper in
                    Alert(title: Text(strings.wishlistError.localized),
                          message: wrapper.error.text)
                }
            }
        }
    }
}

struct ProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductPage(container: AppContainer.preview(),
                    productId: "gid://shopify/Product/8341864055063")
    }
}
