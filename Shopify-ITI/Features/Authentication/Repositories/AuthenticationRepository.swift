//
//  AuthenticationRepository.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct AuthenticationRepository: AnyAuthenticationRepository {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyAuthenticationRepository).self) { resolver in
            AuthenticationRepository(profileService: resolver.require(ProfileRemoteService.self),
                                     authService: resolver.require((any AnyAuthenticationRemoteService).self),
                                     authManager: resolver.require(AuthenticationManager.self))
        }
    }
    
    private let profileService: ProfileRemoteService
    private let authService: any AnyAuthenticationRemoteService
    private let authManager: AuthenticationManager
    
    init(profileService: ProfileRemoteService,
         authService: some AnyAuthenticationRemoteService,
         authManager: AuthenticationManager) {
        self.profileService = profileService
        self.authService = authService
        self.authManager = authManager
    }
    
    func signup(with credentials: SignupCredentials) async -> Result<User, ShopifyErrors<ShopifyAPI.CustomerErrorCode>> {
        return await authService.signup(with: credentials)
    }
    
    func login(with credentials: SigninCredentials) async -> Result<Session, Error> {
        let tokenResult = await authService.login(with: credentials)
        if case .failure(let error) = tokenResult { return .failure(error) }
        guard case .success(let token) = tokenResult else { return .failure(LocalErrors.Unknown) }
        
        let userResult = await profileService.profile(for: token.accessToken)
        if case .failure(let error) = userResult { return .failure(error) }
        guard case .success(let user) = userResult else { return .failure(LocalErrors.Unknown) }
        
        return await authManager.setUser(user: user, token: token).mapError { $0 as Error }
    }
    
    func recover(email: String) async -> Result<Void, ShopifyErrors<ShopifyAPI.CustomerErrorCode>> {
        return await authService.recover(email: email)
    }
}
