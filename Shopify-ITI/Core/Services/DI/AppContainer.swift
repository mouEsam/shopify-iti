//
//  AppContainer.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

enum ServiceType {
    case singleton
    case newSingleton
    case new
    case automatic
}

protocol Resolver {
    func register<Service>(type: Service.Type, name: String?, factory: @escaping (Resolver) -> Service)
    
    func resolve<Service>( _ type: Service.Type) -> Service?
    func resolve<Service>( _ type: Service.Type, _ resolveType: ServiceType) -> Service?
    func resolve<Service>( _ type: Service.Type, _ resolveType: ServiceType, name: String?) -> Service?
}

extension Resolver {
    func require<Service>(_ serviceType: Service.Type, _ resolveType: ServiceType = .automatic, name: String? = nil) -> Service {
        return resolve(serviceType, resolveType, name: name)!
    }
}

class AppContainer: ObservableObject, Resolver {
    private var factories: [ServiceKey: (any Resolver) -> Any] = [:]
    private var cache: [ServiceKey: Any] = [:]
    
    init(injectables: [AnyInjectable.Type]) {
        for injectable in injectables {
            injectable.register(self)
        }
    }
    
    func register<Service>(type: Service.Type, name: String? = nil, factory: @escaping (any Resolver) -> Service) {
        let serviceKey = ServiceKey(serviceType: Service.self, name: name)
        factories[serviceKey] = factory
    }
    
    func resolve<Service>( _ type: Service.Type, _ resolveType: ServiceType = .automatic, name: String? = nil) -> Service? {
        return resolveImpl(type, resolveType, name: name)
    }
    
    private func resolveImpl<Service>( _ type: Service.Type, _ resolveType: ServiceType = .automatic, name: String? = nil) -> Service? {
        let serviceKey = ServiceKey(serviceType: Service.self, name: name)
        switch resolveType {
        case .singleton:
            if let service = cache[serviceKey] as? Service {
                return service
            } else {
                let service = factories[serviceKey]?(self) as? Service

                if let service = service {
                    cache[serviceKey] = service
                }

                return service
            }
        case .newSingleton:
            let service = factories[serviceKey]?(self) as? Service

            if let service = service {
                cache[serviceKey] = service
            }

            return service
        case .automatic:
            fallthrough
        case .new:
            return factories[serviceKey]?(self) as? Service
        }
    }
}

extension AppContainer {
    func resolve<Service>(_ type: Service.Type) -> Service? {
        resolve(type, .automatic, name: nil)
    }
    
    func resolve<Service>(_ type: Service.Type, _ resolveType: ServiceType) -> Service? {
        resolve(type, resolveType, name: nil)
    }
}
