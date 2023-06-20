//
//  SearchModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

protocol AnySearchModel {
    func fetch(byQuery query: String) async -> Result<SourcedData<[String]>, ShopifyErrors<Any>>
}

struct SearchModel: AnySearchModel, AnyInjectable {
     static func register(_ container: AppContainer) {
         container.register(type: (any AnySearchModel).self, scope: .transient) { resolver in
            SearchModel(remoteService: resolver.require(SearchRemoteService.self))
        }
    }
    
    private let remoteService: SearchRemoteService
    
    init(remoteService: SearchRemoteService) {
        self.remoteService = remoteService
    }
    
    func fetch(byQuery query: String) async -> Result<SourcedData<[String]>, ShopifyErrors<Any>> {
        let result = await remoteService.fetch(query: query)
        return result.map { .remote($0) }
    }
}
