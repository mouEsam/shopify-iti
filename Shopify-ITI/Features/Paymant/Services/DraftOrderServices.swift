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
    
    func create(with lineItems:[ShopifyAdminAPI.DraftOrderLineItemInput]) async -> Result<String, DraftOrderError>{
        let customerId = userProvider.user?.id
        
        let input = ShopifyAdminAPI.DraftOrderInput(lineItems: .init(nullable: lineItems) ,
                                                    purchasingEntity: .init(nullable: customerId.map { .init(customerId: .some($0)) }))
        let mutation = ShopifyAdminAPI.CreateDraftOrderMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderCreate {
                if let id = data.draftOrder?.id {
                    return .success(id)
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(DraftOrderError.Generic(genericErrors: errors))
                }
            } else {
                return .failure(DraftOrderError.init(from: result.errors ?? []))
            }
        }
    }
    func update(id: String, with address: String) async -> Result<String, DraftOrderError>{
        let input = ShopifyAdminAPI.DraftOrderInput(billingAddress:
                .init(nullable: ShopifyAdminAPI.MailingAddressInput(address1: .init(nullable: address),
                                                                    city: .init(nullable: "")
                                                                   )))
        let mutation = ShopifyAdminAPI.CreateDraftOrderMutation(input: input)
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderCreate {
                if let id = data.draftOrder?.id {
                    return .success(id)
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(DraftOrderError.Generic(genericErrors: errors))
                }
            } else {
                return .failure(DraftOrderError.init(from: result.errors ?? []))
            }
        }
    }
    func complete(id: String, isPaied: Bool) async -> Result<String, DraftOrderError>{
        let mutation = ShopifyAdminAPI.CompleteDraftOrderMutation(id: id, paymentPending: .init(nullable: isPaied))
        let result = await remoteClient.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.draftOrderComplete {
                if let id = data.draftOrder?.id {
                    return .success(id)
                } else {
                    let errors = data.userErrors.toShopifyErrors()
                    return .failure(DraftOrderError.Generic(genericErrors: errors))
                }
            } else {
                return .failure(DraftOrderError.init(from: result.errors ?? []))
            }
        }
    }
}