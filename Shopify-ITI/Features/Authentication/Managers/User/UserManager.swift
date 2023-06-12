//
//  UserManager.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Combine

protocol AnyUserManager: AnyInjectable {
    var state: UserState { get }
    var statePublisher: Published<UserState>.Publisher { get }
    func setUser(user: User, persist: Bool) -> Result<Void, LocalErrors>
    func delete()
}

class UserManager: AnyUserManager {
    static func register(_ container: AppContainer) {
        container.register(type: AnyUserManager.self) { resolver in
            UserManager(store: resolver.require((any AnyUserLocalStore).self),
                        notificationCenter: resolver.require((any AnyNotificationCenter).self),
                        authService: resolver.require(AuthenticationRemoteService.self),
                        userProvider: resolver.require((any AnyUserHolder).self))
        }
    }
    
    private let store: any AnyUserLocalStore
    private let notificationCenter: any AnyNotificationCenter
    private let authService: AuthenticationRemoteService
    
    private let userProvider: any AnyUserHolder
    
    private var cancellable: AnyCancellable? = nil
    private var task: Task<Any, Error>? = nil
    
    @Published private(set) var state: UserState = .none
    var statePublisher: Published<UserState>.Publisher { $state }
    
    init(store: some AnyUserLocalStore,
         notificationCenter: some AnyNotificationCenter,
         authService: AuthenticationRemoteService,
         userProvider: some AnyUserHolder) {
        self.store = store
        self.notificationCenter = notificationCenter
        self.authService = authService
        self.userProvider = userProvider
        self.initialize()
    }
    
    private func initialize() {
        cancellable = notificationCenter
            .publisher(for: RenewedSessionNotification.name)
            .compactMap { $0.object as? RenewedSessionNotification }
            .sink { _ in self.refreshProfile() }
        
        if case .success(let user) = store.read() {
            handleUser(user)
        }
    }
    
    func refreshProfile() {
        task?.cancel()
        task = Task { await self.refreshProfileImpl() }
    }
    
    private func refreshProfileImpl() async {
        if case .success(let user) = await authService.profile(),
           !Task.isCancelled {
            _ = setUser(user: user, persist: store.exists())
        }
    }
    
    func setUser(user: User, persist: Bool = true) -> Result<Void, LocalErrors> {
        if persist, case .failure(let error) = store.write(user: user) {
            return .failure(error)
        }
        return .success(handleUser(user))
    }
    
    func delete() {
        store.delete()
        handleNoUser()
    }
    
    private func handleUser(_ user: User) {
        userProvider.user = user
        state = .some(user: user)
    }
    
    private func handleNoUser() {
        userProvider.user = nil
        state = .none
    }
}
