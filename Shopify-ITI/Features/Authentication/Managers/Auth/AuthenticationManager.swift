//
//  AuthenticationManager.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Combine

class AuthenticationManager: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: AuthenticationManager.self) { resolver in
            AuthenticationManager(userManager: resolver.require((any AnyUserManager).self),
                                  tokenManager: resolver.require((any AnyTokenManager).self),
                                  guestManager: resolver.require((any AnyGuestManager).self),
                                  notificationCenter: resolver.require((any AnyNotificationCenter).self),
                                  authService: resolver.require(AuthenticationRemoteService.self))
        }
    }
    
    private let userManager: any AnyUserManager
    private let tokenManager: any AnyTokenManager
    private let guestManager: any AnyGuestManager
    private let notificationCenter: any AnyNotificationCenter
    private let authService: AuthenticationRemoteService
    
    private var task: Task<Any, Error>? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    @PostPublished private var stateHolder: AuthenticationState = .unauthenticated
    var statePublisher: PostPublished<AuthenticationState>.Publisher { $stateHolder }
    var state: AuthenticationState { stateHolder }
    
    init(userManager: some AnyUserManager,
         tokenManager: some AnyTokenManager,
         guestManager: some AnyGuestManager,
         notificationCenter: some AnyNotificationCenter,
         authService: AuthenticationRemoteService) {
        self.userManager = userManager
        self.tokenManager = tokenManager
        self.guestManager = guestManager
        self.notificationCenter = notificationCenter
        self.authService = authService
        self.initialize()
    }
    
    private func initialize() {
        notificationCenter
            .publisher(for: EndSessionNotification.name)
            .compactMap { $0.object as? EndSessionNotification }
            .sink { _ in self.delete() }
            .store(in: &cancellables)
        refreshState()
        Publishers.CombineLatest3(guestManager.statePublisher,
                                  userManager.statePublisher,
                                  tokenManager.statePublisher)
        .debounce(for: 0, scheduler: DispatchQueue.global())
        .sink { _ in self.refreshState() }
        .store(in: &cancellables)
    }
    
    func refreshState() {
        task?.cancel()
        task = Task {
            await MainActor.run {
                stateHolder = createState()
            }
        }
    }
    
    private func createState() -> AuthenticationState {
        return createStateImpl(userState: userManager.state,
                               guestState: guestManager.state,
                               tokenState: tokenManager.state)
    }
    
    private func createStateImpl(userState: UserState,
                                 guestState: GuestState,
                                 tokenState: TokenState) -> AuthenticationState {
        if case .some(let user) = userState,
            case .some(let token) = tokenState {
            return .authenticated(user: user, token: token)
        } else if case .some(let guest) = guestState {
            return .guest(guest: guest)
        } else {
            return .unauthenticated
        }
    }
    
    func setUser(user: User, token: AccessToken, persist: Bool = true) -> Result<Session, LocalErrors> {
        let userResult = userManager.setUser(user: user, persist: persist)
        if case let .failure(error) = userResult {
            return .failure(error)
        } else if case let .failure(error) = tokenManager.setToken(token: token, persist: persist) {
            userManager.delete()
            return .failure(error)
        } else {
            return .success(Session(user: user, accessToken: token))
        }
    }
    
    func setGuest(guest: Guest, persist: Bool = true) -> Result<Guest, LocalErrors> {
        return guestManager.setGuest(guest: guest, persist: persist).map { _ in guest }
    }
    
    func logout() {
        task?.cancel()
        task = Task { await self.logoutImpl() }
    }
    
    private func logoutImpl() async {
        if case .success(_) = await authService.signout() {
            delete()
            notificationCenter.post(EndSessionNotification())
        }
    }
    
    func delete() {
        userManager.delete()
        tokenManager.delete()
        guestManager.delete()
    }
}
