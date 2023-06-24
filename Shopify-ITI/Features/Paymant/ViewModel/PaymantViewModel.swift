//
//  PaymantViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 21/06/2023.
//

import Foundation
import Combine
class PaymantViewModel:ObservableObject{
    let draftOrderModel:AnyDraftOrderModel
    private var orderID:String?
    private let cartManager:CartManager
    private let addressManger:AddressManger
    @Published var address: Address
    private var cancellables: Set<AnyCancellable> = []
    @Published var showCobonError: Bool = false

    @Published private(set) var operationState: UIState<DraftOrder> = .initial
    var uiStatePublisher: Published<UIState<DraftOrder>>.Publisher { $operationState }
    let cart:Cart
    init(draftOrderModel:AnyDraftOrderModel,cart:Cart,cartManager:CartManager,addressManger:AddressManger) {
        self.draftOrderModel = draftOrderModel
        self.cart=cart
        self.cartManager = cartManager
        self.addressManger = addressManger
        address = Address(street: "", city: "", state: "", postalCode: "")
        self.initialize()
    }
    private func initialize() {
        addressManger.selectedStatePublisher.prepend(addressManger.selectedState)
            .receive(on: DispatchQueue.global()).sink { addressState in
                switch addressState{
                case .data(data: let addressString):
                    Task{
                        await MainActor.run{
                            self.address = Address.fromString(addressString) ?? Address(street:  "Add Adresss", city: "", state: "", postalCode: "")
                        }
                    }
                case .loading:
                    break
                default:
                    break
                }
            }.store(in: &cancellables)
    }
    func creatOrde()async{
        await MainActor.run{
            operationState = .loading
        }
        let result = await draftOrderModel.createDraftOrder(with: cart.cartLine)
        await MainActor.run{
            if case .success(let order) = result{
                self.orderID=order.id
                operationState = result.toLocal()
            }
        }
    }
    func updateOrde(address: String, discount: String)async{
        if let orderID = orderID{
            
            let result = await draftOrderModel.updateDraftOrder(id: orderID, address: address, discount: discount, andLine: cart.cartLine)
            await MainActor.run{
                switch result{
                case .success(let order):
                    self.orderID=order.id
                    showCobonError = false
                    operationState = result.toLocal()
                case .failure(_):
                    showCobonError = true
                }
               
            }
        }
    }
    func completeOrde(isPaid: Bool)async{
        if let orderID = orderID{
            let result = await draftOrderModel.completeDraftOrder(id: orderID, isPaid: isPaid)
            await cartManager.removeCart()
            
        }
    }
}
