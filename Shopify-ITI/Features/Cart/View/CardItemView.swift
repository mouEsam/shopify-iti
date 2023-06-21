//
//  CardItemView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 21/06/2023.
//

import SwiftUI

struct CardItemView: View {
    
    private var cartLine: CartLine
    private let viewModel:CartViewModel
    private var colors: AnyAppColors
    
    init(container: AppContainer,
         cartLine: CartLine,
         viewModel: CartViewModel) {
        colors = container.require((any AnyAppColors).self)
        self.viewModel = viewModel
        self.cartLine = cartLine
    }
    
    var body: some View {
        HStack(alignment: .top) {
            RemoteImageView(image: cartLine.productVariant.image)
                .frame(width: 100,height: 100)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(cartLine.productVariant.title)
                    .font(.headline)
                HStack {
                    Text("Price: ") //TODO: local
                    PriceView(price: cartLine.totalAmount)
                }
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
                    Button(action: {
                        Task{
                            await  viewModel.decreseItem(cartline: cartLine)
                        }
                        
                    }) {
                        Image("minus")
                            .font(.title)
                    }
                }
                
            }
            Spacer()
            Button(action: {
                Task{
                    await  viewModel.deleteItem(cartline: cartLine)
                }
            }) {
                Image("delete")
                    .renderingMode(.template)
                    .font(.title)
            }
            .foregroundColor(colors.black)
        }.padding(16)

    }
}


