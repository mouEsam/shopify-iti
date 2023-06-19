//
//  ProductItemView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct ProductItemView: View {
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    private let onWishlisted: (() -> Void)?
    private let product: Product
    private let isWishlisted: Bool
    
    init(product: Product,
         isWishlisted: Bool,
         onWishlisted: (() -> Void)? = nil) {
        self.product = product
        self.isWishlisted = isWishlisted
        self.onWishlisted = onWishlisted
    }
    
    var body: some View {
        Button(action: {
            router.push(ProductPage.Route(container: container, productId: product.id))
        }) {
            VStack(alignment: .leading) {
                Group {
                    Rectangle().fill(.clear).background {
                        if let image = product.featuredImage {
                            AsyncImage(url: URL(string:  image.url)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image("Logo").resizable()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .overlay(alignment: .bottomTrailing) {
                    WishlistBag(isWishlisted: isWishlisted, onWishlisted: onWishlisted)
                        .frame(width: 48)
                        .padding(4)
                }
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(product.title)
                            .font(.headline)
                        Spacer()
                        
                    }
                    Spacer().frame(height: 8)
                    Text(product.vendor).font(.caption2)
                    Spacer().frame(height: 16)
                    PriceRangeView(priceRange: product.priceRange)
                        .font(.caption)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}

struct ProductItemView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemView(product: Product(id: "id",
                                         handle: "handle",
                                         title: "title",
                                         vendor: "title",
                                         description: "description",
                                         featuredImage: nil,
                                         priceRange: .init(minPrice: .init(amount: 10,
                                                                           currencyCode: .egp),
                                                           maxPrice: .init(amount: 40,
                                                                           currencyCode: .egp)),
                                         variantId: "variantId"),
                        isWishlisted: true)
    }
}
