//
//  AddressService.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import Foundation
import Shopify_ITI_SDK
struct AddressService:AnyInjectable{
    static func register(_ container: AppContainer) {
        container.register(type: (AddressService).self) { resolver in
            AddressService(remoteClient:resolver.require((any GraphQLClient).self),
                              localeProvider: resolver.require((any AnyLocaleProvider).self),
                           accessTokenProvider:resolver.require((any AnyAccessTokenProvider).self)
            )
        }
    }
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    private let accessTokenProvider:any AnyAccessTokenProvider

    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider,
         accessTokenProvider:some AnyAccessTokenProvider
        ) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
        self.accessTokenProvider = accessTokenProvider
    }
    func saveAddress(adress:String)async->Result<String?,Error>{
        
        if let accessToken =  accessTokenProvider.accessToken{
            let query = ShopifyAPI.CustomerAddressCreateMutation(customerAccessToken: accessToken,
                                                                 address: ShopifyAPI.MailingAddressInput(address1: .init(nullable: adress)))
            let result = await remoteClient.execute(query: query)
            return result.map { result in
                result.data.flatMap { data in
                    data.customerAddressCreate.map { customer in
                        customer.customerAddress?.address1 ?? ""
                    }
                }
            }
        }else{
            return .failure(LocalErrors.Invalid)
        }
    }
    func getAddress()async->Result<[String]?,Error>{
        if let accessToken =  accessTokenProvider.accessToken{
            let query = ShopifyAPI.GetCustomerAddressesQuery(customerAccessToken:accessToken)
            let result = await remoteClient.fetch(query: query)
            return result.map { result in
                result.data.flatMap { data in
                    data.customer.map { customer in
                        customer.addresses.edges.map{ addresse in
                            addresse.node.address1 ?? ""
                        }
                    }
                }
            }
        }else{
            return .failure(LocalErrors.Invalid)
        }
    }
    
}
