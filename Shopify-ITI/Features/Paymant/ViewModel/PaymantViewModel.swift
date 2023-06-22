//
//  PaymantViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 21/06/2023.
//

import Foundation
class PaymantViewModel:ObservableObject{
    let draftOrderModel:AnyDraftOrderModel
    private var orderID:String?
    private let cartManager:CartManager
    
    let cart:Cart
    init(draftOrderModel:AnyDraftOrderModel,cart:Cart,cartManager:CartManager) {
        self.draftOrderModel = draftOrderModel
        self.cart=cart
        self.cartManager = cartManager
    }
    func creatOrde()async{
        let result = await draftOrderModel.createDraftOrder(with: cart.cartLine)
        await MainActor.run{
            if case .success(let orderID) = result{
                self.orderID=orderID
                print(orderID)
            }
        }
    }
    func updateOrde(address: String, discount: String)async{
        if let orderID = orderID{
            let result = await draftOrderModel.updateDraftOrder(id: orderID, address: address, discount: discount)
        }
    }
    func completeOrde(isPaid: Bool)async{
        if let orderID = orderID{
            let result = await draftOrderModel.completeDraftOrder(id: orderID, isPaid: isPaid)
            await cartManager.removeCart()
            
        }
    }
}
