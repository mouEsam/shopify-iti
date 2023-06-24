//
//  PaymantView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import SwiftUI
import PassKit

struct PaymantView: View {
    class Route: AppRoute {
        convenience init(container: AppContainer,cart: Cart) {
            self.init(identifier: String(describing: Self.self)) {
                PaymantView(container: container, cart: cart)
            }
        }
    }
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    private let localeProvider: AnyLocaleProvider
    private let strings : AnyPaymentStrings
    
    
    @State private var coupon: String = ""
    @State private var couponApplied: Bool = false

    @State private var paymentMethod: String = "Cash on delivery"
    @State private var showingPaymentSheet = false
    @State private var address = "address"
    @State private var editedStreet: String = ""
    @State private var editedCity: String = ""
    @State private var editedCountry: String = ""
    @StateObject var viewModel:PaymantViewModel
    
    let cart: Cart
    let paymentHandler = PaymentHandler()
    
    init(container: AppContainer, cart: Cart) {
        self.localeProvider = container.require((any AnyLocaleProvider).self)
        let  cartManager = container.require((CartManager).self)
         strings = container.require((PaymentStrings).self)

        self.cart = cart
        _viewModel = .init(wrappedValue: PaymantViewModel(draftOrderModel: container.require((any AnyDraftOrderModel).self),
                                                          cart: cart,
                                                          cartManager: cartManager, addressManger: container.require((AddressManger).self)))
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: HStack {
                    Text(strings.shippingAddressHeader.localized)
                    Spacer()
                    Button(action: {
                        
                            router.push(AppRoute(identifier:  String(describing: LocationView.self)){
                                LocationView(container: container)
                                
                            })
                    }) {
                        Image("edit")
                    }
                }) {
                    Text(viewModel.address.street)
                        .font(.headline)
                    Text("\(viewModel.address.city), \(viewModel.address.state) \(viewModel.address.postalCode)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Section(header: Text(strings.paymentMethodLabel.localized)) {
                    Picker(selection: $paymentMethod, label: Text(strings.paymentMethodLabel.localized)) {
                        Text(strings.cashOnDelivery.localized).tag("Cash on delivery")
                        Text(strings.applePay.localized).tag("Apple pay")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text(strings.discountCouponLabel.localized)) {
                    HStack{
                        TextField(strings.discountCouponLabel.localized, text: $coupon)
                        Button(action:{
                            Task{
                                await viewModel.updateOrde(address: address, discount: coupon)
                            }
                            couponApplied = true
                        }
                        ){
                            Image("arrow").tint(.white).flipsForRightToLeftLayoutDirection(true)
                        }.aspectRatio(1, contentMode:.fit)
                            .frame(height: 50)
                            .buttonStyle(.borderedProminent)
                            .tint(.black)
                    }
                    if viewModel.showCobonError {
                        Text("Not valid")
                            .foregroundColor(.red).font(.subheadline)
                    }
                }
               
                
                Section(header: Text(strings.priceLabel.localized)) {
                    switch viewModel.operationState{
                    case .loaded(data: let draftOrder):
                        VStack(spacing: 20) {
                            HStack {
                                Text(strings.subTotalLabel.localized)
                                Spacer()
                                PriceView(price: draftOrder.data.subtotalAmount)
                            }
                                HStack {
                                    Text(strings.taxLabel.localized)
                                    Spacer()
                                    PriceView(price: draftOrder.data.totalTaxAmount)
                                }
                            
                            if let discont = draftOrder.data.discontAmount {
                                HStack {
                                    Text(strings.discountLabel.localized)
                                    Spacer()
                                    PriceView(price: discont)
                                }
                            }
                            HStack {
                                Text(strings.totalLabel.localized)
                                Spacer()
                                PriceView(price: draftOrder.data.totalAmount)
                            }
                            
                        }
                    case .error(error: let error):
                        Text(error.localizedDescription)
                    default:
                        ProgressView()
                    }
                }
                
                Section {
                    Button(action: {
                        
                        
                        if paymentMethod == "Cash on delivery" {
                            showingPaymentSheet = true
                        } else if paymentMethod == "Apple pay",
                                  let country = localeProvider.shopifyCountry?.value {
                            self.paymentHandler.startPayment(amount: cart.totalAmount,
                                                             country: country) { success in
                                if success {
                                    Task{
                                        await viewModel.completeOrde(isPaid: true)
                                    }
                                    router.push(AppRoute(identifier:  String(describing: CongratsScreen.self)){
                                        CongratsScreen()
                                        
                                    })
                                    
                                } else {
                                    print("Failed")
                                }
                            }
                        }
                    }) {
                        Text(strings.proceedToPaymentButton.localized)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                    .sheet(isPresented: $showingPaymentSheet) {
                        // Content of the bottom sheet for Cash on delivery
                        VStack {
                            switch viewModel.operationState{
                            case .loaded(data:let draftOrder):
                                HStack{
                                    Text(strings.totalAmountLabel.localized)
                                    Spacer()
                                    PriceView(price:draftOrder.data.totalAmount) // TODO: use currency
                                }.padding(.all)
                            default:
                                ProgressView()
                                
                            }
                            HStack(){
                                Button(action: {
                                    Task{
                                        await viewModel.completeOrde(isPaid: false)
                                        
                                    }
                                    router.push(AppRoute(identifier:  String(describing: CongratsScreen.self)){
                                        CongratsScreen()
                                    })
                                    showingPaymentSheet = false
                                }) {
                                    Text(strings.payButton.localized)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity)
                                }.padding()
                                Button(action: {
                                    // Handle Cash on delivery payment action here
                                    showingPaymentSheet = false
                                }) {
                                    Text(strings.cancelButton.localized)
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity)
                                }.padding()
                            }
                            
                            .frame(maxWidth: .infinity)
                            .buttonStyle(.borderedProminent)
                            .tint(.black)
                        }.presentationDetents([.fraction(0.15)])
                        
                    }
                }
            }
        }.task{
            await viewModel.creatOrde()
        }
    }
    
}



