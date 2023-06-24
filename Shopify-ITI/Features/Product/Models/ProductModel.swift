//
//  ProductModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation

protocol AnyProductModel {
    func fetch(byId id: String) async -> Result<SourcedData<DetailedProduct>, ShopifyErrors<Any>>
}

struct ProductModel: AnyProductModel, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProductModel).self, scope: .transient) { resolver in
            ProductModel(remoteService: resolver.require((any AnyProductRemoteService).self),
                         configsProvider: resolver.require((any AnyConfigsProvider).self))
        }
    }
    
    private let remoteService: any AnyProductRemoteService
    private let configsProvider: any AnyConfigsProvider
    
    init(remoteService: some AnyProductRemoteService,
         configsProvider: some AnyConfigsProvider) {
        self.remoteService = remoteService
        self.configsProvider = configsProvider
    }
    
    func fetch(byId id: String) async -> Result<SourcedData<DetailedProduct>, ShopifyErrors<Any>> {
        let result = await remoteService.fetch(byId: id,
                                         collectionsCount: configsProvider.collectionsCountInProductInfoPage,
                                         imagesCount: configsProvider.imagesCountInProductInfoPage,
                                         variantsCount: configsProvider.variantsCountInProductInfoPage)
        
        return result.map { .remote($0) }
    }
}
