//
//  CartView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 12/06/2023.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var viewModel: CartViewModel
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    private var authManager: AuthenticationManager
    private var colors: AnyAppColors
    
    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        authManager = container.require(AuthenticationManager.self)
        let model = container.require((any AnyCartModel).self)
        _viewModel = .init(wrappedValue: CartViewModel(model: model ))
    }
    
    var body: some View {
        VStack{
            ScrollView {
                switch viewModel.operationState{
                    case .loaded(data: let cart):
                        LazyVStack(spacing: 16) {
                            ForEach(cart.data.cartLine) { item in
                                CardItemView(container: container,
                                             cartLine: item,
                                             viewModel: viewModel)
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
                    if let amount = viewModel.operationState.data?.totalAmount {
                        PriceView(price: amount)
                    }
                }
                RoundedButton(label: "Check Out",
                              labelColor: colors.white,
                              backgroundColor: colors.black) {
                    if case .authenticated = authManager.state {
                        router.push(PaymantView.Route(container: container,
                                                      cart:viewModel.operationState.data!))
                    } else {
                        router.alert(item: IdentifiableWrapper(wrapped: authManager.state)) { _ in
                            Alert(title: Text("Login required"),
                                  message: Text("You must be logged in first to continue"),
                                  primaryButton: Alert.Button.default(Text("Login"),
                                                                      action: { router.push(LoginScreen.Route(container: container)) }),
                                  secondaryButton: Alert.Button.default(Text("OK")))
                        }
                    }
                }
            }.padding(.all)
        }
        .background(colors.white)
        .foregroundColor(colors.black)
        .task {
            await viewModel.getCart()
        }
    }
}

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
        }
        .padding(16)
    }
}


