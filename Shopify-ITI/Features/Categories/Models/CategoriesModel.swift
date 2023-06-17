//
//  CategoriesViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import Foundation

protocol AnyCategoriesModelFactory: AnyInjectable {
    func create() -> any AnyCategoriesModel
}

struct CategoriesModelFactory: AnyCategoriesModelFactory {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCategoriesModelFactory).self) { resolver in
            CategoriesModelFactory(resolver: resolver)
        }
    }
    
    private let resolver: any AppContainer.Resolver
    
    func create() -> AnyCategoriesModel {
        CategoriesModel(remoteService: resolver.require(CategoriesRemoteService.self))
    }
}

protocol AnyCategoriesModel {
    func fetch(CollectionName name:String) async ->Result<[ProductType], Error>
    func getTypes(items arr: inout [ProductType]) -> [ProductType]
}

struct CategoriesModel : AnyCategoriesModel {
    
    private let remoteService:  CategoriesRemoteService //TODO: Inject
    
    init(remoteService:  CategoriesRemoteService) {
        self.remoteService = remoteService
    }
    func fetch(CollectionName name:String) async ->Result<[ProductType], Error> {
       
        let x = await remoteService.fetch(CollectionName: name)
        switch(x) {
        case .success(var data) :
            return .success(getTypes(items: &data))
        case .failure(let erorr):
                return .failure(erorr)
        }
  
    }
    
    func getTypes(items arr: inout [ProductType]) -> [ProductType]{
        let uniqueArr = arr.reduce(into: [ProductType]()) { result, item in
            let key = item.productType 
            if !result.contains(where: { $0.productType == key }) {
                result.append(item)
            }
        }
        return uniqueArr
    }
}
