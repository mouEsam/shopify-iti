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
        OrdersModel(remoteService: resolver.require((any AnyOrdersRemoteService).self), token: resolver.require((any AnyAccessTokenProvider).self))
    }
}

protocol AnyOrdersModel {
    func fetch() async ->Result<[Order], Error>
    
}

struct OrdersModel: AnyOrdersModel{
    
    private let remoteService:  AnyOrdersRemoteService
    private let token :  AnyAccessTokenProvider
    
    init(remoteService: AnyOrdersRemoteService,token :  AnyAccessTokenProvider) {
        self.remoteService = remoteService
        self.token = token
    }
    func initialize() {
       
    }
    
    func fetch() async ->Result<[Order], Error> {
        
        let x = await remoteService.fetch(customerAccessToken: token.accessToken ?? "")
        return  x
      
    }
    

}

