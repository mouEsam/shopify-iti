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
    
    required init(injectables: [AnyInjectable.Type] = []) {
        self.container = Container()
        for injectable in injectables {
            injectable.register(self)
        }
    }
    
    @discardableResult
    func register<Service>(type: Service.Type,
                           name: String? = nil,
                           scope: InstanceScope = .container,
                           factory: @escaping (Resolver) -> Service) -> RegisterEntry {
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

protocol RegisterEntry {
    /// Adds another type which should be resolved using this ServiceEntry - i.e. using the same object scope,
    /// arguments and `initCompleted` closures
    ///
    /// - Parameters:
    ///     - type: Type resolution of which should be forwarded
    ///     - name: A registration name, which is used to differentiate from other registrations of the same `type`
    @discardableResult
    func implements<T>(_ type: T.Type, name: String?) -> Self
}

extension RegisterEntry {
    @discardableResult
    public func implements<T>(_ type: T.Type, name: String? = nil) -> Self {
        return implements<T>(type, name: name)
    }
}

extension ServiceEntry: RegisterEntry {}

extension AppContainer {
    
    // TODO: change
    static func preview() -> Self {
        self.production()
    }
    
    
    static func production() -> Self {
        return Self.init(injectables: [
            UserDefaults.self,
            NotificationCenter.self,
            KeysProvider.self,
            KeyChain.self,
            ConfigsProvider.self,
            LocaleProvider.self,
            JsonCoder.self,
            ApolloGraphQLClient.self,
            StorefronEnvironmentProvider.self,
            AdminEnvironmentProvider.self,
            UserLocalStore.self,
            GuestLocalStore.self,
            TokenLocalStore.self,
            WishlistIdStore.self,
            UserManager.self,
            GuestManager.self,
            TokenManager.self,
            AccessTokenHolder.self,
            UserHolder.self,
            AuthenticationManager.self,
            WishlistManager.self,
            AuthenticationRemoteService.self,
            ProfileRemoteService.self,
            WishlistRemoteService.self,
            ProductRemoteService.self,
            ProductsRemoteService.self,
            SearchRemoteService.self,
            LocalizationRemoteService.self,
            BrandRemoteService.self,
            CategoriesRemoteService.self,
            AuthenticationRepository.self,
            WishlistModel.self,
            ProductModel.self,
            ProductsModel.self,
            BrandModelFactory.self,
            CategoriesModelFactory.self,
            CartModel.self,
            CartRemoteService.self,
            CartManager.self,
            CartIdStore.self,
            AuthenticationStrings.self,
            AppColors.self,
            SettingsModel.self,
            SplashStrings.self,
            LanguageLocalStore.self,
            CountryLocalStore.self,
            SearchRemoteService.self,
            SearchModel.self,
            HomeStrings.self,
            ProfileStrings.self,
            CategoriesStrings.self,
            ProductsStrings.self,
            ProductStrings.self,
            WishlistStrings.self,
            DraftOrderModel.self,
            DraftOrderServices.self,
            DiscountManager.self,
            OrdersStrings.self,
            OrdersModelFactory.self,
            OrdersRemoteService.self,
            PreviousSearchesStore.self
        ])
    }
}
