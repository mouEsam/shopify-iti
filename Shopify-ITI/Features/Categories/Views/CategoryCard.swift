//
//  CategoryCard.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
import SwiftUI
struct CardCategory : View {
    
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    
    private let item: ProductType
    private let idOfCollection : String
    private let colors: AnyAppColors
    
    init(container: AppContainer, item: ProductType, idOfCollection: String) {
        self.item = item
        self.idOfCollection = idOfCollection
        self.colors = container.require((any AnyAppColors).self)
    }
    
    var body: some View {
        Button(action: {
            router.push(ProductsScreen.Route(container: container,
                                             criterion: [.collection:idOfCollection,
                                                         .type:item.productType]))
        }) {
            VStack {
                RemoteImageView(image: item.featuredImage)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 90)
                    .frame(maxWidth: .infinity)
                    .padding(4)
                Text(item.productType)
                    .font(.callout)
                    .fontWeight(.bold)
                    .padding(4)
            }.frame(height: 150)
        }
        .foregroundColor(colors.black)
        .background(colors.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}
