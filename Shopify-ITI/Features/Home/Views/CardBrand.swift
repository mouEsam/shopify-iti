//
//  CardBrand.swift
//  Shopify-ITI
//
//  Created by ammar on 14/06/2023.
//

import SwiftUI

struct CardBrand : View {
    
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    
    private let item : ProductCollection
    private let color : Color
    
    init(item: ProductCollection, color: Color) {
        self.item = item
        self.color = color
    }
    
    var body: some View {
        Button(action: {
            router.push(ProductsScreen.Route(container: container,
                                             criterion: [.collection:item.id]))
        }) {
            VStack {
                AsyncImage(url: URL(string: item.image?.url ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                Text(item.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(color)
                    .padding()
            }.background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
        }

    }
}


