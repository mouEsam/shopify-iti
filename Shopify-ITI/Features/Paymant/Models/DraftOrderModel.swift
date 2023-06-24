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
                            discountManager:  resolver.require(DiscountManager.self),
                            cartIdStore: resolver.require((any AnyCartIdStore).self))
        }
    }
    
    private let draftOrderServices: DraftOrderServices
    private let discountManager:DiscountManager
    private let cartIdStore:AnyCartIdStore

    init(draftOrderServices: DraftOrderServices,discountManager:DiscountManager,cartIdStore:AnyCartIdStore) {
        self.draftOrderServices = draftOrderServices
        self.discountManager = discountManager
        self.cartIdStore = cartIdStore
    }
    
    func createDraftOrder(with items: [CartLine]) async-> Result<DraftOrder, ShopifyErrors<Any>>{
        let lineItems = createLineItems(from: items)
        let result =  await draftOrderServices.create(with: lineItems)
        return  result
    }
    
    func updateDraftOrder(id: String, address: String, discount: String,andLine items: [CartLine]) async-> Result<DraftOrder, ShopifyErrors<Any>>{
        let lineItems = createLineItems(from: items)

        if(discount == "" ){
            return .failure(ShopifyErrors.NotFound)
        }else{
            let orderDiscount = discountManager.createDiscountInput(using: discount)
            if let orderDiscount = orderDiscount{
                return await draftOrderServices.update(id: id, withAddress: address, andDiscount: orderDiscount, with: lineItems)
            }
            return .failure(ShopifyErrors.NotFound)

        }
        
    }
    
    func completeDraftOrder(id: String, isPaid: Bool) async-> Result<DraftOrder, ShopifyErrors<Any>>{
        cartIdStore.delete()

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
    func createDraftOrder(with items: [CartLine]) async -> Result<DraftOrder, ShopifyErrors<Any>>
    func updateDraftOrder(id: String, address: String, discount: String,andLine items: [CartLine]) async-> Result<DraftOrder, ShopifyErrors<Any>>
    func completeDraftOrder(id: String, isPaid: Bool) async -> Result<DraftOrder, ShopifyErrors<Any>>
}
