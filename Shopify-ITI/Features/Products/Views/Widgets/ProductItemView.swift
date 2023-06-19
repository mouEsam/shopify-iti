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
                    Group {
                        let wishlisted = Image(systemName: isWishlisted ? "bag.fill" : "bag")
                            .font(.title)
                        if let onWishlisted = onWishlisted {
                            Button(action: onWishlisted) {
                                wishlisted
                            }
                        } else {
                            wishlisted.padding(8)
                        }
                    }
                    .buttonStyle(.bordered)
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
                    Group {
                        let min = product.priceRange.minPrice.amount
                        let max = product.priceRange.maxPrice.amount
                        
                        let minS = moneyFormatter().string(from: NSNumber(value: min))
                        if min != max,
                           let min = minS,
                           let max = moneyFormatter(false).string(from: NSNumber(value: max)) {
                            Text(min) + Text(" - ") + Text(max)
                        } else if let min = minS {
                            Text(min)
                        }
                    }
                    .font(.caption)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
    
    private func moneyFormatter(_ showCurrency: Bool = true) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if showCurrency {
            formatter.currencyCode = product.priceRange.minPrice.currencyCode.rawValue
        } else {
            formatter.currencyCode = ""
            formatter.currencySymbol = ""
        }
        formatter.locale = Locale.current // Use the current locale for currency symbol and formatting
        return formatter
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
