//
//  MockAuthenticationRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockAuthenticationRemoteService: AnyAuthenticationRemoteService {
    
    var service: AnyAuthenticationRemoteService? = nil
    
    var signupResult: Result<User, AuthError>! = nil
    var loginResult: Result<AccessToken, AuthError>! = nil
    var profileResult: Result<User, AuthError>! = nil
    var renewResult: Result<AccessToken, AuthError>! = nil
    var recoverResult: Result<Void, AuthError>! = nil
    var signoutResult: Result<Void, AuthError>! = nil
    
    func signup(with credentials: SignupCredentials) async -> Result<User, AuthError> {
        if let service = service {
            return await service.signup(with: credentials)
        } else {
            return signupResult
        }
    }
    
    func login(with credentials: SigninCredentials) async -> Result<AccessToken, AuthError> {
        if let service = service {
            return await service.login(with: credentials)
        } else {
            return loginResult
        }
    }
    
    func profile() async -> Result<User, AuthError> {
        if let service = service {
            return await service.profile()
        } else {
            return profileResult
        }
    }
    
    func renew() async -> Result<AccessToken, AuthError> {
        if let service = service {
            return await service.renew()
        } else {
            return renewResult
        }
    }
    
    func recover(email: String) async -> Result<Void, AuthError> {
        if let service = service {
            return await service.recover(email: email)
        } else {
            return recoverResult
        }
    }
    
    func signout() async -> Result<Void, AuthError> {
        if let service = service {
            return await service.signout()
        } else {
            return signoutResult
        }
    }
}
