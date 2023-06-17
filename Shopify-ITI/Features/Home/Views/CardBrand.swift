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
    
    let item : ProductCollection
    
    var body: some View {
        
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
                .foregroundColor(.black)
                .padding()
            
        }.background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .onTapGesture {
                router.push(AppRoute(identifier: item.id, content:{
                    ProductsScreen(container: container, criterion: [.collection:item.id])
                }))
            }
    }

    
}


