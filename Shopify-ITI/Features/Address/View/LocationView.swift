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
    
    @State private var isFormVisible = false
    private let colors : AnyAppColors
//    private let strings : AnyAdderssStrings
    
    init(container: AppContainer) {
        _viewModel = .init(wrappedValue: AddressViewModel(addressManger: container.require((AddressManger).self)))
        colors = container.require((any AnyAppColors).self)
    }
    var body: some View {
        VStack {
            List() {
                ForEach(viewModel.addresses) { address in
                    Button(action: { viewModel.selectAddress(address: address)
                        router.pop()}, label: {
                            cardAddress(address: address,colors: colors)
                        })
                }
            }

            HStack {
                Spacer()
                
                Button(action: {
                    isFormVisible.toggle()
                }) {
                    Image(systemName: isFormVisible ? "minus.circle.fill" : "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }.foregroundColor(.black)
                .padding()
            }
            if isFormVisible {
                VStack {
                    TextField("Street", text: $viewModel.newStreet)
                    TextField("City", text: $viewModel.newCity)
                    TextField("State", text: $viewModel.newState)
                    TextField("Post Code", text: $viewModel.newPostalCode)
                    
                    
                    Button(action:{
                        viewModel.addAddress()
                        router.pop()
                        isFormVisible = false
                        
                        
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
                }.padding()
                
            }
        }
    }
}
struct cardAddress : View{
    let address :Address
//    let strings : AnyAddressStrings
    let colors : AnyAppColors
    var body: some View{
        HStack{
            VStack{
                Text(address.street+","+address.city)
                    .font(.title)
                Text(address.state)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(address.postalCode)
                    .font(.title3)
                    .foregroundColor(.gray)
                
            }.background(.white)
                .shadow(radius: 2)
                .cornerRadius(10)
                .padding(.vertical)
            Spacer()
            Image(systemName: "checkmark").padding(.horizontal)
        }
    }
}
