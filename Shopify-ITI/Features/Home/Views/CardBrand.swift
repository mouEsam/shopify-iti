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
    private let colors : AnyAppColors
    
    init(container: AppContainer,
         item: ProductCollection) {
        self.item = item
        self.colors = container.require((any AnyAppColors).self)
    }
    
    var body: some View {
        Button(action: {
            router.push(ProductsScreen.Route(container: container,
                                             criterion: [.collection:item.id]))
        }) {
            VStack {
                RemoteImageView(image: item.image)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    .padding()
                Text(item.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
            }
        }
        .foregroundColor(colors.black)
        .background(colors.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}


