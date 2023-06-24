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
    private let string: AnyCartStrings
    private let commonString: AnyCommonStrings

    init(container: AppContainer) {
        colors = container.require((any AnyAppColors).self)
        authManager = container.require(AuthenticationManager.self)
        let model = container.require((any AnyCartModel).self)
        let cartManager = container.require((CartManager).self)
        string = container.require((any AnyCartStrings).self)
        commonString = container.require((any AnyCommonStrings).self)
        _viewModel = .init(wrappedValue: CartViewModel(model: model ,cartManager: cartManager))
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
                
                
            case .error(error: _):
                Image("emptyCart").resizable().aspectRatio(1, contentMode: .fit)

            }
            Spacer()
            VStack{
                HStack{
                    Text(string.total.localized)
                    Spacer()
                    if let amount = viewModel.operationState.data?.totalAmount {
                        PriceView(price: amount)
                    }
                }
                RoundedButton(label: string.checkout,
                              labelColor: colors.white,
                              backgroundColor: colors.black) {
                    if case .authenticated = authManager.state {
                        if let cart = viewModel.operationState.data{
                            router.push(PaymantView.Route(container: container,
                                                          cart:cart))
                        }
                        else{
                            router.alert(item:  IdentifiableWrapper(wrapped: viewModel.operationState)){_ in
                                Alert(title: Text(string.emptyCartTitle.localized),
                                      message: Text(string.emptyCartMessage.localized),
                                      dismissButton: Alert.Button.default(Text(commonString.ok.localized)))
            
                            }
                        }
                    } else {
                        router.alert(item: IdentifiableWrapper(wrapped: authManager.state)) { _ in
                            Alert(title: Text(string.loginRequiredTitle.localized),
                                  message: Text(string.loginRequiredMessage.localized),
                                  primaryButton: Alert.Button.default(Text(string.login.localized),
                                                                      action: { router.push(LoginScreen.Route(container: container)) }),
                                  secondaryButton: Alert.Button.default(Text(commonString.ok.localized)))
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


