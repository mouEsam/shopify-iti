//
//  ProductsModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation

protocol AnyProductsModel {
    func fetch(withCriteria criteria: [ProductSearchCriteria:String],
               with paginationInfo: PageInfo?) async -> Result<SourcedData<PageResult<Product>>, ShopifyErrors<Any>>
}

struct ProductsModel: AnyProductsModel, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProductsModel).self, scope: .transient) { resolver in
            ProductsModel(productsService: resolver.require((any AnyProductsRemoteService).self),
                          configsProvider: resolver.require((any AnyConfigsProvider).self))
        }
    }
    
    private let productsService: any AnyProductsRemoteService
    private let configsProvider: any AnyConfigsProvider
    
    init(productsService: some AnyProductsRemoteService,
         configsProvider: some AnyConfigsProvider) {
        self.productsService = productsService
        self.configsProvider = configsProvider
    }
    
    func fetch(withCriteria criteria: [ProductSearchCriteria:String],
               with paginationInfo: PageInfo? = nil) async -> Result<SourcedData<PageResult<Product>>, ShopifyErrors<Any>> {
        let result = await productsService.fetch(withCriterion: criteria,
                                                 count: configsProvider.productsCountPerPage,
                                                 with: paginationInfo)
        return result.map { SourcedData.remote($0) }
    }
}
