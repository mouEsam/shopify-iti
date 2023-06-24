//
//  MockAuthenticationRepository.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
import Shopify_ITI_SDK
@testable import Shopify_ITI

class MockAuthenticationRepository: AnyAuthenticationRepository {
    
    var repository: AuthenticationRepository? = nil
    
    var signupResult: Result<User, ShopifyErrors<ShopifyAPI.CustomerErrorCode>>! = nil
    var loginResult: Result<Session, Error>! = nil
    var recoverResult: Result<Void, ShopifyErrors<ShopifyAPI.CustomerErrorCode>>! = nil
    
    func signup(with credentials: SignupCredentials) async -> Result<User, ShopifyErrors<ShopifyAPI.CustomerErrorCode>> {
        if let repository = repository {
            return await repository.signup(with: credentials)
        } else {
            return signupResult
        }
    }
    
    func login(with credentials: SigninCredentials) async -> Result<Session, Error> {
        if let repository = repository {
            return await repository.login(with: credentials)
        } else {
            return loginResult
        }
    }
    
    func recover(email: String) async -> Result<Void, ShopifyErrors<ShopifyAPI.CustomerErrorCode>> {
        if let repository = repository {
            return await repository.recover(email: email)
        } else {
            return recoverResult
        }
    }
}
