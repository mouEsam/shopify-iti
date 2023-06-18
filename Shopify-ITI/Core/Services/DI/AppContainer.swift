//
//  AppContainer.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Swinject

enum InstanceScope {
    /// A new instance is always created by the ``Container`` when a type is resolved.
    /// The instance is not shared.
    case transient

    /// Instances are shared only when an object graph is being created,
    /// otherwise a new instance is created by the ``Container``. This is the default scope.
    case graph

    /// An instance provided by the ``Container`` is shared within the ``Container`` and its child `Containers`.
    case container

    /// An instance provided by the ``Container`` is shared within the ``Container`` and its child ``Container``s
    /// as long as there are strong references to given instance. Otherwise new instance is created
    /// when resolving the type.
    case weak
}

extension InstanceScope {
    fileprivate var objectScope: ObjectScope {
        switch self {
            case .transient:
                return .transient
            case .graph:
                return .graph
            case .container:
                return .container
            case .weak:
                return .weak
        }
    }
}

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
    
    func register<Service>(type: Service.Type,
                           name: String? = nil,
                           scope: InstanceScope = .container,
                           factory: @escaping (Resolver) -> Service) {
        container.register(type, name: name, factory: factory).inObjectScope(scope.objectScope)
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
