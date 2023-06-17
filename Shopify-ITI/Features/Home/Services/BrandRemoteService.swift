//
//  BrandRemoteService.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct BrandRemoteService : AnyInjectable{
    
    static func register(_ container: AppContainer) {
        container.register(type: BrandRemoteService.self) { resolver in
            BrandRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                 localeProvider: resolver.require((any AnyLocaleProvider).self))
        }
    }
    
    typealias BrandError = ShopifyErrors<Any>

    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider 
    
    init(remoteClient: any GraphQLClient, localeProvider: any AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(count : Int) async -> Result<[ProductCollection], Error> {
        let query = ShopifyAPI.GetBrandsQuery(first: count, country: .init(nullable: localeProvider.shopifyCountry), lang:  .init(nullable: localeProvider.shopifyLanguage))
        
        let result = await remoteClient.fetch(query: query)
        switch result {
           case .success(let res):
            let mappedData = res.data?.collections.edges.map { edge in
                   ProductCollection(from: edge.node)
            } ?? nil
            
            if let data = mappedData {
                return .success(data )
            }
            return .failure(BrandError.NotFound)
               
           case .failure(let error):
               return .failure(error)
           }
    }
}
