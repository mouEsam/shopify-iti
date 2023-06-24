//
//  MockCartRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by ahmed alameir on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI_SDK

@testable import Shopify_ITI
class MockCartRemoteService: AnyCartRemoteService {
    var cartRemoteService: AnyCartRemoteService?=nil
    
    var fetchByIdReturnValue: Result<Cart?, Error>?
    
    var createCartReturnValue: Result<Cart?, Error>?
    
    var updateCardReturnValue: Result<Cart?, Error>?
    
    var updateLineForCardReturnValue: Result<Cart?, Error>?
    
    var removeLineReturnValue: Result<Cart?, Error>?
    
    var updateBuyerIdentityReturnValue: Result<Cart?, Error>?
    
    func fetch(byId id: String) async -> Result<Cart?, Error> {
        if let cartRemoteService = cartRemoteService{
            return  await cartRemoteService.fetch(byId : id)
        }
        return fetchByIdReturnValue ?? .success(nil)
    }
    
    func createCart(with cartInput: ShopifyAPI.CartInput) async -> Result<Cart?, Error> {
        if let cartRemoteService = cartRemoteService{
            return  await cartRemoteService.createCart(with: cartInput)
        }
        return createCartReturnValue ?? .success(nil)
    }
    
    func upDate(card id: String, with lineInput: ShopifyAPI.CartLineInput) async -> Result<Cart?, Error> {
        if let cartRemoteService = cartRemoteService{
            return  await cartRemoteService.upDate(card: id, with: lineInput)
        }
        return updateCardReturnValue ?? .success(nil)
    }
    
    func upDateLineFor(card id: String, with lineInput: ShopifyAPI.CartLineUpdateInput) async -> Result<Cart?, Error> {
        if let cartRemoteService = cartRemoteService{
            return  await cartRemoteService.upDateLineFor(card: id, with: lineInput)
        }
        return updateLineForCardReturnValue ?? .success(nil)
    }
    
    func removeLine(withLineID lineId: String, forCart cartId: String) async -> Result<Cart?, Error> {
        if let cartRemoteService = cartRemoteService{
            return  await cartRemoteService.removeLine(withLineID: lineId, forCart: cartId)
        }
        return removeLineReturnValue ?? .success(nil)
    }
    
    func upDataBuyerIdentity(withUserID userId: String?, forCart cartId: String) async -> Result<Cart?, Error> {
        if let cartRemoteService = cartRemoteService{
            return  await cartRemoteService.upDataBuyerIdentity(withUserID: userId, forCart: cartId)
        }
        return updateBuyerIdentityReturnValue ?? .success(nil)
    }
}
