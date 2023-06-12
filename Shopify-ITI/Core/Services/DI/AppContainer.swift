//
//  AppContainer.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Swinject

class AppContainer: ObservableObject {
    typealias Resolver = Swinject.Resolver
    private let container: Container
    
    private init(resolver: Container) {
        self.container = resolver
    }
    
    init(parent: AppContainer) {
        self.container = Container(parent: parent.container)
    }
    
    init(injectables: [AnyInjectable.Type] = []) {
        self.container = Container()
        for injectable in injectables {
            injectable.register(self)
        }
    }
    
    func register<Service>(type: Service.Type, name: String? = nil, factory: @escaping (Resolver) -> Service) {
        container.register(type, name: name, factory: factory)
    }
    
    func resolve<Service>( _ type: Service.Type, name: String? = nil) -> Service? {
        return container.resolve(type, name: name)
    }
    
    func require<Service>( _ type: Service.Type, name: String? = nil) -> Service {
        return resolve(type, name: name)!
    }
}

extension Resolver {
    func require<Service>( _ type: Service.Type, name: String? = nil) -> Service {
        return resolve(type, name: name)!
    }
}
