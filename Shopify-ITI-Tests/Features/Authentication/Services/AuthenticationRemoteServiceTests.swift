//
//  AuthenticationRemoteServiceTests.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import XCTest
import Shopify_ITI_SDK
import Apollo
@testable import Shopify_ITI

final class AuthenticationRemoteServiceTests: XCTestCase {
    
    private var client: MockRemoteClient!
    private var localeProvider: MockLocaleProvider!
    private var tokenProvider: MockAccessTokenProvider!
    private var remoteService: AuthenticationRemoteService!
    
    private let errorResult = MockGraphQLResult.ResultType.clientError(error: MockError())
    
    private let createCustomerSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("customerCreate", JSONObject([
            ("__typename", JSONValue("CustomerCreate")),
            ("customer", JSONObject([
                ("__typename", JSONValue("Customer")),
                ("id", JSONValue("id")),
                ("displayName", JSONValue("displayName")),
                ("firstName", JSONValue("firstName")),
                ("lastName", JSONValue("firstName")),
                ("email", JSONValue("email")),
                ("phone", JSONValue("phone")),
                ("password", JSONValue("password")),
            ])),
            ("customerUserErrors", [JSONObject]())
        ])),
    ]))
    
    private let createAccessTokenSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("customerAccessTokenCreate", JSONObject([
            ("__typename", JSONValue("CustomerAccessTokenCreate")),
            ("customerAccessToken", JSONObject([
                ("__typename", JSONValue("CustomerAccessToken")),
                ("accessToken", JSONValue("AccessToken")),
                ("expiresAt", JSONValue("2023-06-23T00:00:00Z")),
            ])),
            ("customerUserErrors", [JSONObject]())
        ])),
    ]))
    
    private let getCustomerSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("customer", JSONObject([
            ("__typename", JSONValue("Customer")),
            ("id", JSONValue("id")),
            ("displayName", JSONValue("displayName")),
            ("firstName", JSONValue("firstName")),
            ("lastName", JSONValue("firstName")),
            ("email", JSONValue("email")),
            ("phone", JSONValue("phone")),
            ("password", JSONValue("password")),
            ("acceptsMarketing", JSONValue(false)),
        ])),
    ]))
    
    private let renewAccessTokenSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("customerAccessTokenRenew", JSONObject([
            ("__typename", JSONValue("CustomerAccessTokenCreate")),
            ("customerAccessToken", JSONObject([
                ("__typename", JSONValue("CustomerAccessToken")),
                ("accessToken", JSONValue("AccessToken")),
                ("expiresAt", JSONValue("2023-06-23T00:00:00Z")),
            ])),
            ("userErrors", [JSONObject]())
        ])),
    ]))
    
    private let recoverSuccessResult = MockGraphQLResult.ResultType.found(data: JSONObject([
        ("customerRecover", JSONObject([
            ("__typename", JSONValue("CustomerAccessTokenCreate")),
            ("customerUserErrors", [JSONObject]())
        ])),
    ]))
    
    override func setUp() {
        client = MockRemoteClient()
        tokenProvider = MockAccessTokenProvider()
        localeProvider = MockLocaleProvider()
        remoteService = AuthenticationRemoteService(client: client,
                                                    localeProvider: localeProvider,
                                                    tokenProvider: tokenProvider)
    }
    
    func testLoginSuccess() async {
        client.executeResult  = MockGraphQLResult(result: createAccessTokenSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.login(with: .init(email: "", password: ""))
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testLoginClientError() async {
        client.executeResult  = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.login(with: .init(email: "", password: ""))
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testLoginFailure() async {
        client.executeResult  = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.login(with: .init(email: "", password: ""))
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testSignupSuccess() async {
        client.executeResult  = MockGraphQLResult(result: createCustomerSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.signup(with: .init(firstName: "",
                                                            lastName: "",
                                                            email: "",
                                                            phone: "",
                                                            password: ""))
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testSignupClientError() async {
        client.executeResult  = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.signup(with: .init(firstName: "",
                                                            lastName: "",
                                                            email: "",
                                                            phone: "",
                                                            password: ""))
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testSignupFailure() async {
        client.executeResult  = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        
        let result = await remoteService.signup(with: .init(firstName: "",
                                                            lastName: "",
                                                            email: "",
                                                            phone: "",
                                                            password: ""))
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testProfileSuccess() async {
        client.fetchResult  = MockGraphQLResult(result: getCustomerSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.profile()
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testProfileClientError() async {
        client.fetchResult  = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.profile()
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testProfileFailure() async {
        client.fetchResult  = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.profile()
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testRenewSuccess() async {
        client.executeResult  = MockGraphQLResult(result: renewAccessTokenSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.renew()
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testRenewClientError() async {
        client.executeResult  = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.renew()
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testRenewFailure() async {
        client.executeResult  = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.renew()
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testRecoverSuccess() async {
        client.executeResult  = MockGraphQLResult(result: recoverSuccessResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.recover(email: "")
        if case .failure(_) = result {
            XCTFail()
        }
    }
    
    func testRecoverClientError() async {
        client.executeResult  = MockGraphQLResult(result: errorResult)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.recover(email: "")
        if case .success(_) = result {
            XCTFail()
        }
    }
    
    func testRecoverFailure() async {
        client.executeResult  = MockGraphQLResult(result: .error)
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"
        tokenProvider.accessTokenResult = "token"
        
        let result = await remoteService.recover(email: "")
        if case .success(_) = result {
            XCTFail()
        }
    }
}

