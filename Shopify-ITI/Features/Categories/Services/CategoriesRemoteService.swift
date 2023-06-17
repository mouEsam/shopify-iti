//
//  CategoriesRemoteService.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
import Shopify_ITI_SDK

class CategoriesRemoteService {
    typealias CategoriesError = ShopifyErrors<Any>
    
    private let remoteClient: any GraphQLClient // TODO: inject
    private let localeProvider: any AnyLocaleProvider // TODO: inject
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
