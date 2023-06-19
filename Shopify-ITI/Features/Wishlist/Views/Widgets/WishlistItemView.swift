//
//  WishlistItemView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct WishlistItemView: View {
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    @State private var task: Task<Any, Error>? = nil
    private let onRemove: (() async -> Void)?
    private let product: Product
    
    init(product: Product,
         onRemove: (() async -> Void)? = nil) {
        self.product = product
        self.onRemove = onRemove
    }
    
    var body: some View {
        Button(action: {
            router.push(ProductPage.Route(container: container, productId: product.id))
        }) {
            HStack(alignment: .top) {
                RemoteImageView(image: product.featuredImage)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, alignment: .center)
                .padding()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(product.title)
                            .font(.headline)
                        Spacer()
                        if let onRemove = onRemove {
                            Button(action: {
                                task?.cancel()
                                task = Task { await onRemove() }
                            }) {
                                Image( "delete")
                                    .font(.title)
                            }
                        }
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

struct WishlistItemView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistItemView(product: Product(id: "id",
                                          handle: "handle",
                                          title: "title",
                                          vendor: "title",
                                          description: "description",
                                          featuredImage: nil,
                                          priceRange: .init(minPrice: .init(amount: 10,
                                                                            currencyCode: .egp),
                                                            maxPrice: .init(amount: 40,
                                                                            currencyCode: .egp)),
                                          variantId: "variantId"))
    }
}
