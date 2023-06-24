//
//  LocationView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import SwiftUI
//struct LocationView: View {
//    @StateObject private var viewModel:AddressViewModel
//    @EnvironmentRouter private var router: AppRouter
//
//    init(container: AppContainer) {
//        _viewModel = .init(wrappedValue: AddressViewModel(addressManger: container.require((AddressManger).self)))
//    }
//    var body: some View {
//        VStack {
//            LazyVStack(alignment: .leading) {
//                ForEach(viewModel.addresses) { address in
//                    VStack(alignment: .leading) {
//                        Text(address.street)
//                            .font(.headline)
//                        Text("\(address.city), \(address.state) \(address.postalCode)")
//                            .font(.subheadline)
//                            .foregroundColor(.gray)
//                    }.onTapGesture {
//                        viewModel.selectAddress(address: address)
//                        router.pop()
//                    }
//                }
//            }
//            .padding()
//
//            Group {
//                TextField("Street", text: $viewModel.newStreet)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("City", text: $viewModel.newCity)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("State", text: $viewModel.newState)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                TextField("Postal Code", text: $viewModel.newPostalCode)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button(action:{
//                    viewModel.addAddress()
//                    router.pop()
//
//                }) {
//                    Text("Add to Address")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(10)
//                }
//                .padding()
//                if viewModel.isAnyFieldEmpty {
//                    Text("Please fill in all fields")
//                        .foregroundColor(.red)
//                        .padding(.top, 10)
//                }
//            }
//        }
//    }
//}
struct LocationView: View {
    @State private var isFormVisible = false
    
    @StateObject private var viewModel:AddressViewModel
    @EnvironmentRouter private var router: AppRouter

    init(container: AppContainer) {
        _viewModel = .init(wrappedValue: AddressViewModel(addressManger: container.require((AddressManger).self)))
    }
    var body: some View {
        VStack {
            List(viewModel.addresses) { address in
                cardAddress(ViewModel: viewModel, address: address).onTapGesture {
                    self.viewModel.selectAddress(address: address)
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
                }
                .padding()
            }
            
            if isFormVisible {
                VStack {
                                        
                    TextField("AddressStrings.street".localized, text:$viewModel.newStreet)
                    TextField("AddressStrings.city".localized, text:$viewModel.newCity)
                    TextField("AddressStrings.state".localized, text: $viewModel.newState)
                    TextField("AddressStrings.country".localized, text: $viewModel.newPostalCode)

                    
                    Button("AddressStrings.addAddress".localized) {
                        viewModel.addAddress()
                        isFormVisible = false
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}
struct cardAddress : View{
    @ObservedObject var ViewModel:AddressViewModel
    let address :Address
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(address.street+","+address.city)
                    .font(.title)
                Text(address.state)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(address.state)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }.background(.white)
                .shadow(radius: 2)
                .cornerRadius(10)
                .padding(.vertical)
            Spacer()
            if let selectedaddresse = ViewModel.selectedaddresse,selectedaddresse.street==address.street{
                Image(systemName: "checkmark").padding(.horizontal)

            }
            
        }
    }
}
