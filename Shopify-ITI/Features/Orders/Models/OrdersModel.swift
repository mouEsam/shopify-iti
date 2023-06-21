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
        OrdersModel(remoteService: resolver.require(OrdersRemoteService.self))
    }
}

protocol AnyOrdersModel {
    func fetch(customerAccessToken token : String) async ->Result<[Order], Error>
    
}

struct OrdersModel: AnyOrdersModel{
    
    private let remoteService:  OrdersRemoteService
    
    init(remoteService: OrdersRemoteService) {
        self.remoteService = remoteService
    }
    
    func fetch(customerAccessToken token : String) async ->Result<[Order], Error> {
       
        let x = await remoteService.fetch(customerAccessToken: token)
        return  x
      
    }
    

}

