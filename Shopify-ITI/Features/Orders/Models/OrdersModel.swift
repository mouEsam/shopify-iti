//
//  OrdersModel.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation

protocol AnyOrdersModelFactory: AnyInjectable {
    func create() -> any AnyOrdersModel
}

struct OrdersModelFactory: AnyOrdersModelFactory {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyOrdersModelFactory).self) { resolver in
            OrdersModelFactory(resolver: resolver)
        }
    }
    
    private let resolver: any AppContainer.Resolver
    
    func create() -> AnyOrdersModel {
        OrdersModel(remoteService: resolver.require(BrandRemoteService.self))
    }
}

protocol AnyOrdersModel {
    func fetch(numberOfItem count:Int) async ->Result<[ProductCollection], Error>
}

struct OrdersModel: AnyOrdersModel{
    
    private let remoteService:  BrandRemoteService 
    
    init(remoteService: BrandRemoteService) {
        self.remoteService = remoteService
    }
    func fetch(numberOfItem count:Int) async ->Result<[ProductCollection], Error> {
       
        let x = await remoteService.fetch(count: count)
        return x.toRemote()
      
    }
    

}

