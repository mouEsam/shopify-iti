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
        NavigationView {
            VStack{
                ScrollView {
                    switch viewModel.operationState{
                    case .loaded(data: let cart):
                        LazyVStack(spacing: 16) {
                            
                            ForEach(cart.data.cartLine) { item in
                                CardItemView(cartLine: item,viewModel: viewModel)
                            }
                        }
                        .padding()
                    case .initial:
                        Text("initial")
                        
                    case .loading:
                        Text("loading")
                        
                        
                    case .error(error: let error):
                        Text(error.localizedDescription)
                    }
                }
                VStack{
                    HStack{
                        Text("Total:")
                        Spacer()
                        switch viewModel.operationState{
                        case .loading:
                            Text("$")
                            
                        case .initial:
                            Text("$")

                        case .loaded(data: let cart):
                            Text("$"+String(cart.data.totalAmount))

                        case .error(error: _):
                            Text("$")

                        }
                    }
                    Button(action: {print("pay")}){
                        Text("Check Out")
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)

                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                }.padding(.all)
            }.task {
                await viewModel.getCart()
            }
        }
    }
}

struct CardItemView: View {
     var cartLine: CartLine
    let viewModel:CartViewModel
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string: cartLine.productVariant.image?.url ?? "")){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.aspectRatio(contentMode: .fit)
                .frame(width: 100,height: 100)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(cartLine.productVariant.title)
                    .font(.headline)
                Text("Price: $"+String(cartLine.totalAmount)) //TODO: local

                Spacer()

                HStack(spacing: 16) {
                    Button(action: {
                        Task{
                            await  viewModel.increseItem(cartline: cartLine)
                        }
                        print("plus")
                    }) {
                        Image("plus")
                            .font(.title)
                    }
                    Text(String(cartLine.quantity))
                        .foregroundColor(.black)
                    
                    Button(action: {
                        Task{
                            await  viewModel.decreseItem(cartline: cartLine)
                        }

                    }) {
                        Image("minus")
                            .font(.title)
                    }
                    
                   
                }
                .foregroundColor(.blue)
            }
            Spacer()
            Button(action: {
                Task{
                    await  viewModel.deleteItem(cartline: cartLine)
                }
                print("delete")

            }) {
                Image( "delete")
                    .font(.title)
            }
        }
        .padding(16)
    }
}


