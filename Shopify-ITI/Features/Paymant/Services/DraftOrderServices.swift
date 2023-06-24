//
//  OrderServices.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK
struct DraftOrderServices:AnyInjectable{
    static func register(_ container: AppContainer) {
        container.register(type: DraftOrderServices.self) { resolver in
            DraftOrderServices(remoteClient: resolver.require((any GraphQLClient).self,
                                                                 name: AdminEnvironmentProvider.diName),
                                localeProvider: resolver.require((any AnyLocaleProvider).self),
                                 configsProvider: resolver.require((any AnyConfigsProvider).self),
                                  userProvider: resolver.require((any AnyUserProvider).self))
        }
    }
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    private let configsProvider: any AnyConfigsProvider
    private let userProvider: any AnyUserProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider,
         configsProvider: some AnyConfigsProvider,
         userProvider: some AnyUserProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
        self.configsProvider = configsProvider
        self.userProvider = userProvider
    }
    typealias DraftOrderError = ShopifyErrors<Any>
    
    func create(with lineItems:[ShopifyAdminAPI.DraftOrderLineItemInput]) async -> Result<DraftOrder, DraftOrderError>{
        let customerId = userProvider.user?.id
        
        let input = ShopifyAdminAPI.DraftOrderInput(lineItems: .init(nullable: lineItems) ,
                                                    purchasingEntity: .init(nullable: customerId.map { .init(customerId: .some($0)) }))
        let mutation = ShopifyAdminAPI.CreateDraftOrderMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderCreate {
                if let draftOrder = data.draftOrder {
                    return .success(.init(draftOrder: draftOrder))
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(DraftOrderError.Generic(errors: errors))
                }
            } else {
                return .failure(DraftOrderError.init(from: result.errors ?? []))
            }
        }
    }
    func update(id: String, withAddress address: String,andDiscount discount:ShopifyAdminAPI.DraftOrderAppliedDiscountInput?,with lineItems:[ShopifyAdminAPI.DraftOrderLineItemInput]) async -> Result<DraftOrder, DraftOrderError>{
        let customerId = userProvider.user?.id

        let input = ShopifyAdminAPI.DraftOrderInput(
            appliedDiscount: .init(nullable: discount),
            lineItems: .init(nullable: lineItems) ,
            shippingAddress:.init(nullable: ShopifyAdminAPI.MailingAddressInput(address1: .init(nullable: address))),
            purchasingEntity: .init(nullable: customerId.map { .init(customerId: .some($0)) })
        )
        let mutation = ShopifyAdminAPI.CreateDraftOrderMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderCreate {
                if let draftOrder = data.draftOrder {
                    return .success(.init(draftOrder: draftOrder))
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(DraftOrderError.Generic(errors: errors))
                }
            } else {
                return .failure(DraftOrderError.init(from: result.errors ?? []))
            }
        }
    }
    func complete(id: String, isPaied: Bool) async -> Result<DraftOrder, DraftOrderError>{
        let mutation = ShopifyAdminAPI.CompleteDraftOrderMutation(id: id, paymentPending: .init(nullable: isPaied))
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderComplete {
                if let draftOrder = data.draftOrder {
                    return .success(.init(draftOrder: draftOrder))
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(DraftOrderError.Generic(errors: errors))
                }
            } else {
                return .failure(DraftOrderError.init(from: result.errors ?? []))
            }
        }
    }
}
