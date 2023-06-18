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
    
    let item: ProductType
    let idOfCollection : String
    var body: some View {
        Button(action: {
            router.push(ProductsScreen.Route(container: container,
                                             criterion: [.collection:idOfCollection,
                                                         .type:item.productType]))
        }) {
            VStack {
                Image(item.productType.lowercased())
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 90)
                    .padding(4)
                
                Text(item.productType)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.black).padding(4)
                
                
            }.frame(height: 150)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
        }
    }
}
