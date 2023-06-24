//
//  CategoriesRemoteService.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
import Shopify_ITI_SDK

protocol AnyCategoriesRemoteService{
    typealias CategoriesError = ShopifyErrors<Any>
    
    func fetch(CollectionName name : String) async -> Result<[ProductType], Error>
    
}
struct CategoriesRemoteService : AnyInjectable , AnyCategoriesRemoteService {
    
    static func register(_ container: AppContainer) {
        container.register(type: CategoriesRemoteService.self) { resolver in
            CategoriesRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                 localeProvider: resolver.require((any AnyLocaleProvider).self))
        }.implements(AnyCategoriesRemoteService.self)
    }
    
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    init(remoteClient: any GraphQLClient, localeProvider: any AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(CollectionName name : String) async -> Result<[ProductType], Error> {
        let query = ShopifyAPI.GetCollectionQuery(name: name, country: .init(nullable: localeProvider.shopifyCountry), lang:  .init(nullable: localeProvider.shopifyLanguage))
        
        let result = await remoteClient.fetch(query: query)
        switch result {
           case .success(let res):
            let mappedData = res.data?.collection?.products.nodes.map{product in
                ProductType(from: product)
            } ?? nil
            if let data = mappedData {
                return .success(data )
            }
            return .failure(CategoriesError.NotFound)
               
           case .failure(let error):
               return .failure(error)
           }
    }
}
