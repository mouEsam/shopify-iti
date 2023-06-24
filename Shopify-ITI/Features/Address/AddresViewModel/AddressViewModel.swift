//
//  AddressViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import Foundation
import Combine
class AddressViewModel: ObservableObject {
    
    
    let  addressManger:AddressManger
    @Published var addresses: [Address] = []
    @Published var selectedaddresse: Address? = nil

    var isAnyFieldEmpty: Bool {
            newStreet.isEmpty || newCity.isEmpty || newState.isEmpty || newPostalCode.isEmpty
        }

    private var cancellables: Set<AnyCancellable> = []
    @Published var newStreet = ""
    @Published var newCity = ""
    @Published var newState = ""
    @Published var newPostalCode = ""
    init(addressManger: AddressManger) {
        self.addressManger = addressManger
        self.initialize()
    }

    private func initialize() {
        addressManger.statePublisher.prepend(addressManger.state)
            .receive(on: DispatchQueue.global()).sink { addressState in
                switch addressState{
                case .data(data: let addressString):
                    Task{
                       await MainActor.run{
                            self.addresses = addressString.map{
                                Address.fromString( $0)
                            }
                            .compactMap{$0}
                        }
                        
                    }
                   
                case .loading:
                    break
                default:
                    self.addresses = []
                }
            }.store(in: &cancellables)
        addressManger.selectedStatePublisher.prepend(addressManger.selectedState)
            .receive(on: DispatchQueue.global()).sink { addressState in
                switch addressState{
                case .data(data: let addressString):
                    Task{
                       await MainActor.run{
                           if let addressString = Address.fromString( addressString){
                               self.selectedaddresse = addressString

                           }
                        }
                        
                    }
                   
                case .loading:
                    break
                default:
                    self.addresses = []
                }
            }.store(in: &cancellables)
    }
    
    func addAddress() {
        guard !newStreet.isEmpty && !newCity.isEmpty && !newState.isEmpty && !newPostalCode.isEmpty else {
            return
        }
        
        let newAddress = Address(street: newStreet, city: newCity, state: newState, postalCode: newPostalCode)
        Task{
           await addressManger.saveAddress(address: newAddress.toString())
        }
        
        newStreet = ""
        newCity = ""
        newState = ""
        newPostalCode = ""
    }
    func selectAddress(address :Address) {
        addressManger.selectAddress(address: address.toString())
    }
}
