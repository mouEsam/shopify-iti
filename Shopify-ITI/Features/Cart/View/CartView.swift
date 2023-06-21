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
            Spacer()

            switch viewModel.operationState{
            case .loaded(data: let cart):
                CartScrollView(viewModel: viewModel, cart: cart.data)
            case .initial:
                Text("initial")
                
            case .loading:
               ProgressView()
                
                
            case .error(error: let error):
                Image("emptyCart").resizable().aspectRatio(1, contentMode: .fit)

            }
            Spacer()
            VStack{
                HStack{
                    Text("Total:")
                    Spacer()
                    if let amount = viewModel.operationState.data?.totalAmount {
                        PriceView(price: Price(amount: amount,
                                               currencyCode: .egp))
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
struct CartScrollView: View {
    @ObservedObject private var viewModel: CartViewModel
    @EnvironmentObject private var container: AppContainer
    let cart: Cart
    init(viewModel: CartViewModel,cart:Cart) {
        
        self.viewModel = viewModel
        self.cart = cart
    }
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(cart.cartLine) { item in
                    CardItemView(container: container, cartLine: item, viewModel: viewModel)
                }
            }
            .padding()
        }
    }
}


