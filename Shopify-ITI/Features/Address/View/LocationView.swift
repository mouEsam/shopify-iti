//
//  LocationView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import SwiftUI
struct LocationView: View {
    @StateObject private var viewModel:AddressViewModel
    @EnvironmentRouter private var router: AppRouter

    init(container: AppContainer) {
        _viewModel = .init(wrappedValue: AddressViewModel(addressManger: container.require((AddressManger).self)))
    }
    var body: some View {
        VStack {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.addresses) { address in
                    VStack(alignment: .leading) {
                        Text(address.street)
                            .font(.headline)
                        Text("\(address.city), \(address.state) \(address.postalCode)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }.onTapGesture {
                        viewModel.selectAddress(address: address)
                        router.pop()
                    }
                }
            }
            .padding()
            
            Group {
                TextField("Street", text: $viewModel.newStreet)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("City", text: $viewModel.newCity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("State", text: $viewModel.newState)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Postal Code", text: $viewModel.newPostalCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action:{
                    viewModel.addAddress()
                    router.pop()
                    
                }) {
                    Text("Add to Address")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                if viewModel.isAnyFieldEmpty {
                    Text("Please fill in all fields")
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }
        }
    }
}
