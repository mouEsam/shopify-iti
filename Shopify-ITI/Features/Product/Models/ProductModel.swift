//
//  ProductModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation

protocol AnyProductModelFactory: AnyInjectable {
    func create() -> any AnyProductModel
}

struct ProductModelFactory: AnyProductModelFactory {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProductModelFactory).self) { resolver in
            ProductModelFactory(resolver: resolver)
        }
    }
    
    private let resolver: any AppContainer.Resolver
    
    init(resolver: any AppContainer.Resolver) {
        self.resolver = resolver
    }
    
    func create() -> AnyProductModel {
        ProductModel(remoteService: resolver.require(ProductRemoteService.self),
                     configsProvider: resolver.require((any AnyConfigsProvider).self))
    }
}

protocol AnyProductModel {
    func fetch(byId id: String) async -> Result<SourcedData<DetailedProduct>, ShopifyErrors<Any>>
}

struct ProductModel: AnyProductModel {
    
    private let remoteService: ProductRemoteService
    private let configsProvider: any AnyConfigsProvider
    
    init(remoteService: ProductRemoteService,
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
