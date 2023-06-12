//
//  TokenManager.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Combine

protocol AnyTokenManager: AnyInjectable {
    var state: TokenState { get }
    var statePublisher: Published<TokenState>.Publisher { get }
    func setToken(token: AccessToken, persist: Bool) -> Result<Void, LocalErrors>
    func delete()
}

class TokenManager: AnyTokenManager {
    static func register(_ container: AppContainer) {
        container.register(type: AnyTokenManager.self) { resolver in
            TokenManager(store: resolver.require((any AnyTokenLocalStore).self),
                        notificationCenter: resolver.require((any AnyNotificationCenter).self),
                         authService: resolver.require(AuthenticationRemoteService.self),
                         tokenHolder: resolver.require((any AnyAccessTokenHolder).self))
        }
    }
    
    private let store: any AnyTokenLocalStore
    private let notificationCenter: any AnyNotificationCenter
    private let authService: AuthenticationRemoteService
    
    private let tokenProvider: any AnyAccessTokenHolder
    private var timer: Timer? = nil
    private var task: Task<Any, Error>? = nil
    
    @Published private(set) var state: TokenState = .none
    var statePublisher: Published<TokenState>.Publisher { $state }
    
    init(store: some AnyTokenLocalStore,
         notificationCenter: some AnyNotificationCenter,
         authService: AuthenticationRemoteService,
         tokenHolder: some AnyAccessTokenHolder) {
        self.store = store
        self.notificationCenter = notificationCenter
        self.authService = authService
        self.tokenProvider = tokenHolder
        self.initialize()
    }
    
    private func initialize() {
        if case .success(let token) = store.read() {
            handleToken(token)
        }
    }
    
    func getTokenProvider() -> any AnyAccessTokenProvider {
        return tokenProvider
    }
    
    func refreshProfile() {
        task?.cancel()
        task = Task { await self.refreshProfileImpl() }
    }
    
    private func refreshProfileImpl() async {
        if case .success(let token) = await authService.renew(),
           !Task.isCancelled {
            notificationCenter.post(RenewedSessionNotification())
            _ = setToken(token: token, persist: store.exists())
        }
    }
    
    func setToken(token: AccessToken, persist: Bool = true) -> Result<Void, LocalErrors> {
        if persist, case .failure(let error) = store.write(token: token) {
            return .failure(error)
        }
        return .success(handleToken(token))
    }
    
    func delete() {
        store.delete()
        handleNoToken()
    }
    
    private func handleToken(_ token: AccessToken) {
        tokenProvider.accessToken = token.accessToken
        state = .some(token: token)
        if !token.isValid {
            timer?.invalidate()
            timer = Timer(fire: token.expiresAt, interval: 0, repeats: false, block: { _ in
                self.refreshProfile()
            })
        }
    }
    
    private func handleNoToken() {
        tokenProvider.accessToken = nil
        state = .none
    }
}
