//
//  BrandModel.swift
//  Shopify-ITI
//
//  Created by ammar on 14/06/2023.
//

import Foundation

protocol AnyBrandModelFactory: AnyInjectable {
    func create() -> any AnyBrandModel
}

struct BrandModelFactory: AnyBrandModelFactory {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyBrandModelFactory).self) { resolver in
            BrandModelFactory(resolver: resolver)
        }
    }
    
    private let resolver: any AppContainer.Resolver
    
    func create() -> AnyBrandModel {
        BrandModel(remoteService: resolver.require((any AnyBrandRemoteService).self))
    }
}

protocol AnyBrandModel {
    func fetch(numberOfItem count:Int) async ->Result<[ProductCollection], Error>
    func removeFirstItme(items arr: inout [ProductCollection]) -> [ProductCollection]
}

struct BrandModel: AnyBrandModel{
    
    private let remoteService:  AnyBrandRemoteService 
    
    init(remoteService: AnyBrandRemoteService) {
        self.remoteService = remoteService
    }
    func fetch(numberOfItem count:Int) async ->Result<[ProductCollection], Error> {
       
        let x = await remoteService.fetch(count: count)
        switch(x) {
        case .success(var data) :
            return .success(removeFirstItme(items: &data))
        case .failure(let erorr):
                return .failure(erorr)
        }
  
    }
    
    internal func removeFirstItme(items arr: inout [ProductCollection]) -> [ProductCollection]{
        if(!arr.isEmpty){
            arr.remove(at: 0)
        }
        return arr
    }
}

