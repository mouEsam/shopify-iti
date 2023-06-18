//
//  WishlistItemView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct WishlistItemView: View {
    
    @EnvironmentRouter private var router: AppRouter
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string:  product.featuredImage?.url ?? "")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.aspectRatio(contentMode: .fit)
                .frame(width: 100,height: 100)
                .padding()
            Text(product.title)
                .font(.headline)
                .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
