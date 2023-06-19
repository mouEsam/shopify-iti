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
    @State private var currentPage = 0
    
    private let colors: AnyAppColors = AppColors()
    
    init(container: AppContainer, productId: String) {
        let model = container.require((any AnyProductModelFactory).self).create()
        let manager = container.require(WishlistManager.self)
        _viewModel = .init(wrappedValue: ProductViewModel(productId:productId,
                                                          model: model,
                                                          wishlistManager: manager))
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                ScrollView {
                    TabView(selection: $currentPage) {
                        ForEach(ClosedRange(uncheckedBounds: (lower: 0, upper: 9)), id: \.self) { index in
                            Image("onboarding")
                                .resizable()
                                .frame(maxWidth: .infinity)
                            
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(50, corners: layoutDirection == .leftToRight ? .bottomLeft : .bottomRight)
                    .padding(.leading, 40)
                    .tabViewStyle(.page(indexDisplayMode: .always))
                    VStack(alignment: .leading) {
                        Text("Minimal Stand")
                            .font(.title)
                            .fontWeight(.medium)
                        
                        HStack {
                            PriceRangeView(priceRange: .init(minPrice: .init(amount: 10,
                                                                             currencyCode: .egp),
                                                             maxPrice: .init(amount: 40,
                                                                             currencyCode: .egp)))
                            .font(.title2)
                            .fontWeight(.heavy)
                            Spacer()
                            HStack(spacing: 16) {
                                Button(action: {
                                    
                                }) {
                                    Image("plus")
                                        .font(.title)
                                }
                                Text(String(01))
                                    .foregroundColor(.black)
                                
                                Button(action: {
                                    
                                }) {
                                    Image("minus")
                                        .font(.title)
                                }
                            }
                            .foregroundColor(.blue)
                        }
                        
                        Text("Long text very long")
                            .font(.caption)
                            .foregroundColor(colors.dark2Grey)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.leading, safeAreaInsets.leading)
                    .padding(.trailing, safeAreaInsets.trailing)
                    .padding(.horizontal, 24)
                }
                
                HStack {
                    WishlistBag(isWishlisted: true) {
                        
                    }
                    
                    RoundedButton(label: "Add to cart", labelColor: colors.white, backgroundColor: colors.black) {
                        
                    }
                }
                .frame(maxHeight: 56)
                .padding(.leading, safeAreaInsets.leading)
                .padding(.trailing, safeAreaInsets.trailing)
                .padding(.horizontal, 24)
            }
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
        .edgesIgnoringSafeArea([.top, .horizontal])
        .toolbar(.hidden)
        .onFirstTask {
            await viewModel.fetch()
        }
    }
}

struct ProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductPage(container: AppContainer.preview(),
                    productId: "gid://shopify/Product/8341864055063")
    }
}
