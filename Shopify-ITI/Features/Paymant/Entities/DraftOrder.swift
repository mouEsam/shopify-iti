//
//  DraftOrder.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 24/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK
struct DraftOrder{
    let id:String
    let subtotalAmount: Price
    let totalAmount: Price
    let totalTaxAmount: Price
    let discontAmount: Price?
}
extension DraftOrder{
    init(draftOrder:ShopifyAdminAPI.CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder){
        id = draftOrder.id
        subtotalAmount = .init(from: draftOrder.subtotalPriceSet.presentmentMoney)
                             
        totalAmount = .init(from: draftOrder.totalPriceSet.presentmentMoney)
        totalTaxAmount = .init(from: draftOrder.totalTaxSet.presentmentMoney)
        if let amount = draftOrder.appliedDiscount?.amountV2{
            discontAmount = Price(from: amount)

        }else{
            discontAmount=nil
        }
    }
}
extension DraftOrder{
    init(draftOrder:ShopifyAdminAPI.UpdateDraftOrderMutation.Data.DraftOrderUpdate.DraftOrder){
        id = draftOrder.id
        subtotalAmount = .init(from: draftOrder.subtotalPriceSet.presentmentMoney)
                             
        totalAmount = .init(from: draftOrder.totalPriceSet.presentmentMoney)
        totalTaxAmount = .init(from: draftOrder.totalTaxSet.presentmentMoney)
        if let amount = draftOrder.appliedDiscount?.amountV2{
            discontAmount = Price(from: amount)

        }else{
            discontAmount=nil
        }
    }
}
extension DraftOrder{
    init(draftOrder:ShopifyAdminAPI.CompleteDraftOrderMutation.Data.DraftOrderComplete.DraftOrder){
        id = draftOrder.id
        subtotalAmount = .init(from: draftOrder.subtotalPriceSet.presentmentMoney)
                             
        totalAmount = .init(from: draftOrder.totalPriceSet.presentmentMoney)
        totalTaxAmount = .init(from: draftOrder.totalTaxSet.presentmentMoney)
        if let amount = draftOrder.appliedDiscount?.amountV2{
            discontAmount = Price(from: amount)

        }else{
            discontAmount=nil
        }
    }
}
extension ShopifyAdminAPI.CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder.AppliedDiscount.AmountV2 :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.UpdateDraftOrderMutation.Data.DraftOrderUpdate.DraftOrder.AppliedDiscount.AmountV2 :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.CompleteDraftOrderMutation.Data.DraftOrderComplete.DraftOrder.AppliedDiscount.AmountV2 :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder.SubtotalPriceSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.UpdateDraftOrderMutation.Data.DraftOrderUpdate.DraftOrder.SubtotalPriceSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.CompleteDraftOrderMutation.Data.DraftOrderComplete.DraftOrder.SubtotalPriceSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder.TotalTaxSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.UpdateDraftOrderMutation.Data.DraftOrderUpdate.DraftOrder.TotalTaxSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.CompleteDraftOrderMutation.Data.DraftOrderComplete.DraftOrder.TotalTaxSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}

extension ShopifyAdminAPI.CreateDraftOrderMutation.Data.DraftOrderCreate.DraftOrder.TotalPriceSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.UpdateDraftOrderMutation.Data.DraftOrderUpdate.DraftOrder.TotalPriceSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
extension ShopifyAdminAPI.CompleteDraftOrderMutation.Data.DraftOrderComplete.DraftOrder.TotalPriceSet.PresentmentMoney :PriceConvertible{
    var amount: String {
        let amount = (Double(amount100) ?? 0)
        return String(amount)
    }
}
