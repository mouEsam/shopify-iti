//
//  PaymantView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import SwiftUI
import PassKit

struct PaymantView: View {
    @State private var coupon: String = ""
    @State private var paymentMethod: String = "Cash on delivery"
    @State private var showingPaymentSheet = false
    let paymentHandler = PaymentHandler()

    var body: some View {
        
        NavigationView {
            VStack{
                Form {
                    Section(header:HStack{
                        Text("Shipping Address")
                        Spacer()
                        Button(action: {
                            
                        }){
                            Image("edit")
                        }
                        
                    }
                    ) {
                        Text("placeholder Name")
                        Text("adrres")
                        
                    }
                    
                    Section(header: Text("Payment Method")) {
                        Picker(selection: $paymentMethod, label: Text("Payment Method")) {
                            Text("Cash on delivery").tag("Cash on delivery")
                            Text("PayPal").tag("PayPal")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("discount coupon")) {
                        TextField("add coupon", text: $coupon)
                    }
                    
                    Section(header: Text("price")) {
                        VStack(spacing: 20){
                            HStack{
                                Text("SubTotal:")
                                Spacer()
                                Text("$")
                            }
                            HStack{
                                Text("Tax:")
                                Spacer()
                                Text("$")
                            }
                            HStack{
                                Text("Total:")
                                Spacer()
                                Text("$")
                            }
                            
                        }
                    }
                    
                    Section() {
                        Button(action: {            self.paymentHandler.startPayment { (success) in
                            if success {
                                print("Success")
                            } else {
                                print("Failed")
                            }
                        }
                        }){
                            Text("Go To paymant")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                            
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .tint(.black)
                    }.listRowBackground(Color.clear)

                    
                }


                
            }.navigationBarTitle("Checkout")
        }
    }
}

struct PaymantView_Previews: PreviewProvider {
    static var previews: some View {
        PaymantView()
    }
}
