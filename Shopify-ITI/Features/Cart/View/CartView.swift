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
            }.task {
                await viewModel.getCart()
            }.navigationBarItems(
                leading: NavigationLink(destination: SearchView()) {
                    Image(systemName: "magnifyingglass")
                }, trailing:
                    HStack {
                        
                        NavigationLink(destination: FavouriteView()) {
                            Image(systemName: "heart")
                        }
                    }
            )
        }
    }
}
//struct CartView: View {
//    var body: some View {
//        NavigationView {
//            Text("Cart View ")
//                .navigationBarItems(
//                    leading: NavigationLink(destination: SearchView()) {
//                        Image(systemName: "magnifyingglass")
//                    }, trailing:
//                        HStack {
//
//                            NavigationLink(destination: FavouriteView()) {
//                                Image(systemName: "heart")
//                            }
//                        }
//                )
//
//        }
//    }
//}
// let result = await service.fetch(byId: "gid://shopify/Cart/c1-8abc7310f95b047f1dc83898369d5e18")
//print(result)
struct CardItemView: View {
     var cartLine: CartLine
    let viewModel:CartViewModel
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
                        Task{
                            await  viewModel.increseItem(cartline: cartLine)
                        }
                        print("plus")
                    }) {
                        Image("plus")
                            .font(.title)
                    }
                    Text("\(cartLine.quantity)")
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


