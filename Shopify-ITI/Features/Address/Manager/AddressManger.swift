//
//  AddressManger.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import Foundation
import Combine
class AddressManger:AnyInjectable{
    static func register(_ container: AppContainer) {
        container.register(type: AddressManger.self) { resolver in
            AddressManger(addressService: resolver.require(AddressService.self))
            
        }
    }

    typealias State = Resource<[String]>
    typealias SelectedState = Resource<String>

    let addressService:AddressService
    private var task: Task<Any, Error>? = nil
    private var cancellables: Set<AnyCancellable> = []
    @PostPublished private var stateHolder: State = .loading
    var statePublisher: PostPublished<State>.Publisher { $stateHolder }
    var state: State { stateHolder }
    @PostPublished private var selectedStateHolder: SelectedState = .loading
    var selectedStatePublisher: PostPublished<SelectedState>.Publisher { $selectedStateHolder }
    var selectedState: SelectedState { selectedStateHolder}
    
    init(addressService: AddressService) {
        self.addressService = addressService
    }
    private func initialize() {
        task?.cancel()
        task = Task {
            await getAddress()
        }
    }
    
   
    
    func selectAddress(address: String){
        self.selectedStateHolder = .data(data: address)
    }
    func saveAddress(address: String)async {
        await MainActor.run{
            self.selectedStateHolder = .loading
        }
        let result =  await  addressService.saveAddress(adress: address)
        switch result {
        case .success(let address):
            if let address = address{
                    self.selectedStateHolder = .data(data: address)
                
            }else{
                    self.selectedStateHolder = .none
                
            }
        case.failure(let error):
                self.selectedStateHolder = .error(error: error)
            
        }
        await getAddress()
    }
    func getAddress()async {
        await MainActor.run{
            self.stateHolder = .loading
        }
        let result =  await  addressService.getAddress()

        switch result {
        case .success(let addresses):
            if let addresses = addresses{
                await MainActor.run{
                    self.stateHolder = .data(data: addresses)
                    switch selectedStateHolder{
                    case .loading,.none:
                        if let addresse = addresses.first{
                            self.selectedStateHolder = .data(data: addresse)
                        }else{
                            self.selectedStateHolder = .none
                        }
                    default:
                        break
                    }
                    
                }
            }else{
                await MainActor.run{
                    self.stateHolder = .none
                }
            }
        case.failure(let error):
            await MainActor.run{
                self.stateHolder = .error(error: error)
            }
        }
    }
}
