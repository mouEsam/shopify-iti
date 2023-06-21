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
    
    @EnvironmentRouter private var router: AppRouter
    private let localeProvider: AnyLocaleProvider
    
    @State private var coupon: String = ""
    @State private var paymentMethod: String = "Cash on delivery"
    @State private var showingPaymentSheet = false
    @State private var showingEditSheet = false
    @State private var address = "address"
    @State private var editedStreet: String = ""
    @State private var editedCity: String = ""
    @State private var editedCountry: String = ""
    @StateObject var viewModel:PaymantViewModel
    
    let cart: Cart
    let paymentHandler = PaymentHandler()
    
    init(container: AppContainer, cart: Cart) {
        self.localeProvider = container.require((any AnyLocaleProvider).self)
        self.cart = cart
        _viewModel = .init(wrappedValue: PaymantViewModel(draftOrderModel: container.require((any AnyDraftOrderModel).self), cart: cart))
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: HStack {
                    Text("Shipping Address")
                    Spacer()
                    Button(action: {
                        showingEditSheet = true
                    }) {
                        Image("edit")
                    }
                }) {
                    Text("placeholder Name")
                    Text(address)
                }
                
                Section(header: Text("Payment Method")) {
                    Picker(selection: $paymentMethod, label: Text("Payment Method")) {
                        Text("Cash on delivery").tag("Cash on delivery")
                        Text("Apple pay").tag("Apple pay")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("discount coupon")) {
                    TextField("add coupon", text: $coupon)
                }
                
                Section(header: Text("price")) {
                    VStack(spacing: 20) {
                        HStack {
                            Text("SubTotal:")
                            Spacer()
                            PriceView(price: cart.totalAmount)
                        }
                        HStack {
                            Text("Tax:")
                            Spacer()
                            PriceView(price: cart.totalAmount)
                        }
                        HStack {
                            Text("Total:")
                            Spacer()
                            PriceView(price: cart.totalAmount)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        Task{
                            await viewModel.updateOrde(address: address, discount: coupon)
                        }
                        
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
                        Text("Proceed To Payment")
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
                            HStack{
                                Text("Total Amount: ")
                                Spacer()
                                PriceView(price: cart.totalAmount) // TODO: use currency
                            }.padding(.all)
                            HStack(){
                                Button(action: {
                                    Task{
                                        print("1")
                                        await viewModel.completeOrde(isPaid: false)
                                        
                                    }
                                    router.push(AppRoute(identifier:  String(describing: CongratsScreen.self)){
                                        CongratsScreen()
                                    })
                                    showingPaymentSheet = false
                                }) {
                                    Text("Pay")
                                        .foregroundColor(.white)
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity)
                                }.padding()
                                Button(action: {
                                    // Handle Cash on delivery payment action here
                                    showingPaymentSheet = false
                                }) {
                                    Text("cancel")
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
            }.sheet(isPresented: $showingEditSheet) {
                // Content of the edit sheet
                VStack {
                    TextEditor(text: $editedStreet)
                        .padding()
                    
                    TextEditor(text: $editedCity)
                        .padding()
                    
                    TextEditor(text: $editedCountry)
                        .padding()
                    
                    // Add more TextEditor views for other address fields if needed
                    
                    Button("Done") {
                        // Apply the changes to the cart's shipping address
                        address = createAddressString()
                        showingEditSheet = false
                    }.padding()
                }
            }
        }.task{
            await viewModel.creatOrde()
        }
    }
    func createAddressString() -> String {
        return "Street: \(editedStreet)City: \(editedCity)Country: \(editedCountry)"
    }
}



