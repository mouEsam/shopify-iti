//
//  OrdersServices.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct OrdersRemoteService : AnyInjectable{
    
    static func register(_ container: AppContainer) {
        container.register(type: OrdersRemoteService.self) { resolver in
            OrdersRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                 localeProvider: resolver.require((any AnyLocaleProvider).self))
        }
    }
    
    typealias OrdersError = ShopifyErrors<Any>

    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    init(remoteClient: any GraphQLClient, localeProvider: any AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(customerAccessToken token : String) async -> Result<[Order], Error> {
        let query = ShopifyAPI.GetOrdersQuery(customerAccessToken: token, country: .init(nullable: localeProvider.shopifyCountry), lang: .init(nullable: localeProvider.shopifyLanguage))
   
        
        let result = await remoteClient.fetch(query: query)
        
        switch result {
           case .success(let res):
            let mappedData = res.data?.customer?.orders.edges.map{edge in Order(from:edge.node) } ?? nil
            if let data = mappedData {
                return .success(data )
            }
            
            return .failure(OrdersError.NotFound)
               
           case .failure(let error):
               return .failure(error)
           }
    }
}
