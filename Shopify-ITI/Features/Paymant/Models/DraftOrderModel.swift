//
//  DraftOrderModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 20/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK
struct DraftOrderModel:AnyDraftOrderModel {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyDraftOrderModel).self){resolver in
            DraftOrderModel(draftOrderServices: resolver.require(DraftOrderServices.self),
                            discountManager:  resolver.require(DiscountManager.self))
        }
    }
    
    private let draftOrderServices: DraftOrderServices
    private let discountManager:DiscountManager
    init(draftOrderServices: DraftOrderServices,discountManager:DiscountManager) {
        self.draftOrderServices = draftOrderServices
        self.discountManager = discountManager
    }
    
    func createDraftOrder(with items: [CartLine]) async-> Result<String, ShopifyErrors<Any>>{
        let lineItems = createLineItems(from: items)
        let result =  await draftOrderServices.create(with: lineItems)
        return  result
    }
    
    func updateDraftOrder(id: String, address: String, discount: String) async-> Result<String, ShopifyErrors<Any>>{
        if(discount == "" ){
            return  await draftOrderServices.update(id: id, withAddress: address, andDiscount: nil)

        }else{
            let orderDiscount = discountManager.createDiscountInput(using: discount)
            if let orderDiscount = orderDiscount{
                return await draftOrderServices.update(id: id, withAddress: address, andDiscount: orderDiscount)
            }
            return .failure(ShopifyErrors.NotFound)

        }
        
    }
    
    func completeDraftOrder(id: String, isPaid: Bool) async-> Result<String, ShopifyErrors<Any>>{
        let result =  await draftOrderServices.complete(id: id, isPaied: isPaid)
        return  result
    }
    private func createLineItems(from items: [CartLine]) -> [ShopifyAdminAPI.DraftOrderLineItemInput] {
          return items.map { item in
              return ShopifyAdminAPI.DraftOrderLineItemInput(quantity: item.quantity,variantId: .init(nullable: item.productVariant.id))
          }
      }
}
protocol AnyDraftOrderModel:AnyInjectable {
    func createDraftOrder(with items: [CartLine]) async -> Result<String, ShopifyErrors<Any>>
    func updateDraftOrder(id: String, address: String, discount: String) async -> Result<String, ShopifyErrors<Any>>
    func completeDraftOrder(id: String, isPaid: Bool) async -> Result<String, ShopifyErrors<Any>>
}
