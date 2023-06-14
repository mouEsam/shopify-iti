//
//  CartView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 12/06/2023.
//

import SwiftUI

struct CartView: View {
    @StateObject private var viewModel: CartViewModel
    init(container: AppContainer) {
        let model = container.require((any AnyCartModel).self)
        _viewModel = .init(wrappedValue: CartViewModel(model: model ))
    }
    

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
//                ForEach($viewModel.cart.cartLine ?? <#default value#>) { item in
//                    CardItemView(cartLine: item)
//                }
            }
            .padding()
        }.task {
            
        }
    }
}
// let result = await service.fetch(byId: "gid://shopify/Cart/c1-8abc7310f95b047f1dc83898369d5e18")
//print(result)
struct CardItemView: View {
    @Binding var cartLine: CartLine
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: cartLine.productVariant.image?.url ?? ""))
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            VStack(alignment: .leading, spacing: 8) {
                Text(cartLine.productVariant.title)
                    .font(.headline)
                Text("Price: $\(cartLine.totalAmount, specifier: "%.2f")") //TODO: local
                Spacer()

                HStack(spacing: 16) {
                    Button(action: {
                        print("plus")
                    }) {
                        Image("plus")
                            .font(.title)
                    }
                    Text("\(cartLine.quantity)")
                        .foregroundColor(.black)
                    
                    Button(action: {
                        print("minus")

                    }) {
                        Image("minus")
                            .font(.title)
                    }
                    
                   
                }
                .foregroundColor(.blue)
            }
            Spacer()
            Button(action: {
                
            }) {
                Image( "delete")
                    .font(.title)
            }
        }
        .padding(16)
    }
}


