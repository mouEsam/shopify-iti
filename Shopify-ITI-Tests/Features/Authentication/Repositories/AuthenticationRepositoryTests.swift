//
//  AuthenticationRepositoryTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class AuthenticationRepositoryTests: XCTestCase {
    
    private var configsProvider: ConfigsProvider!
    private var localeProvider: MockLocaleProvider!
    private var profileService: MockProfileRemoteService!
    private var remoteService: MockAuthenticationRemoteService!
    private var authManager: MockAuthenticationManager!
    private var model: AuthenticationRepository!
    
    private let user = User(id: "gid://shopify/Customer/7029803778327",
                            displayName: "User",
                            firstName: "User",
                            lastName: "",
                            email: "user@test.com",
                            phone: "")
    
    private let token = AccessToken(accessToken: "token", expiresAt: Date())

    override func setUp() {
        configsProvider = ConfigsProvider()
        remoteService = MockAuthenticationRemoteService()
        profileService = MockProfileRemoteService()
        localeProvider = MockLocaleProvider()
        authManager = MockAuthenticationManager()
        model = AuthenticationRepository(profileService: profileService,
                                         authService: remoteService,
                                         authManager: authManager)
    }
    
    func testLoginSuccess() async {
        remoteService.loginResult = .success(token)
        profileService.profileForResult = Result.success(user)
        authManager.setUserResult = .success(.init(user: user, accessToken: token))
        
        let result = await model.login(with: .init(email: "", password: ""))
        
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testLoginFailure() async {
        remoteService.loginResult = .failure(.Unknown)
        
        let result = await model.login(with: .init(email: "", password: ""))
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testSignupSuccess() async {
        remoteService.signupResult = .success(user)
        let result = await model.signup(with: .init(firstName: "",
                                                    lastName: "",
                                                    email: "",
                                                    phone: "",
                                                    password: ""))
        
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testSignupFailure() async {
        remoteService.signupResult = .failure(.Unknown)
        let result = await model.signup(with: .init(firstName: "",
                                                    lastName: "",
                                                    email: "",
                                                    phone: "",
                                                    password: ""))
        
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testRecoverSuccess() async {
        remoteService.recoverResult = .success(Void())
        let result = await model.recover(email: "")
        
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testRecoverFailure() async {
        remoteService.recoverResult = .failure(.Unknown)
        let result = await model.recover(email: "")
        
        if case .success(_) = result {
            XCTFail()
        }
    }
}
