//
//  AuthenticationRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct AuthenticationRemoteService: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: AuthenticationRemoteService.self) { resolver in
            AuthenticationRemoteService(client: resolver.require((any GraphQLClient).self),
                                        localeProvider: resolver.require((any AnyLocaleProvider).self),
                                        tokenProvider: resolver.require((any AnyAccessTokenProvider).self))
        }
    }
    
    typealias AuthError = ShopifyErrors<ShopifyAPI.CustomerErrorCode>
    
    private let client: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    private let tokenProvider: any AnyAccessTokenProvider
    
    init(client: any GraphQLClient,
         localeProvider: any AnyLocaleProvider,
         tokenProvider: any AnyAccessTokenProvider) {
        self.client = client
        self.localeProvider = localeProvider
        self.tokenProvider = tokenProvider
    }
    
    func signup(with credentials: SignupCredentials) async -> Result<User, AuthError> {
        let input = ShopifyAPI.CustomerCreateInput(firstName: .init(nullable: credentials.firstName),
                                                   lastName: .init(nullable: credentials.lastName),
                                                   email: credentials.email,
                                                   phone: .init(nullable: credentials.phone),
                                                   password: credentials.password)
        let mutation = ShopifyAPI.CreateCustomerAccountMutation(
            input: input,
            country: .init(nullable: localeProvider.shopifyCountry),
            lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.customerCreate {
                if let customer = data.customer {
                    let user = User(from: customer)
                    return .success(user)
                } else {
                    let errors = data.customerUserErrors.map { AuthError.ValidationError(from: $0) }
                    return .failure(AuthError.Validation(validationErrors: errors))
                }
            } else {
                return .failure(AuthError.Unknown)
            }
        }
    }
    
    func login(with credentials: SigninCredentials) async -> Result<AccessToken, AuthError> {
        let input = ShopifyAPI.CustomerAccessTokenCreateInput(email: credentials.email,
                                                              password: credentials.password)
        let mutation = ShopifyAPI.CreateCustomerAccessTokenMutation(
            input: input,
            country: .init(nullable: localeProvider.shopifyCountry),
            lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.execute(query: mutation)
        
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.customerAccessTokenCreate {
                if let accessToken = data.customerAccessToken {
                    let user = AccessToken(from: accessToken)
                    return .success(user)
                } else {
                    let errors = data.customerUserErrors.map { AuthError.ValidationError(from: $0) }
                    return .failure(AuthError.Validation(validationErrors: errors))
                }
            } else {
                return .failure(AuthError.Unknown)
            }
        }
    }
    
    func profile() async -> Result<User, AuthError> {
        guard let token = tokenProvider.accessToken else { return .failure(.Unautherized) }
        let query = ShopifyAPI.GetCustomerWithAccessTokenQuery(
            customerAccessToken: token,
            country: .init(nullable: localeProvider.shopifyCountry),
            lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data {
                if let user = data.customer {
                    let user = User(from: user)
                    return .success(user)
                } else {
                    return .failure(AuthError.NotFound)
                }
            } else {
                return .failure(AuthError.Unknown)
            }
        }
    }
    
    func renew() async -> Result<AccessToken, AuthError> {
        guard let token = tokenProvider.accessToken else { return .failure(.Unautherized) }
        let mutation = ShopifyAPI.RenewCustomerAccessTokenMutation(
            customerAccessToken: token,
            country: .init(nullable: localeProvider.shopifyCountry),
            lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.execute(query: mutation)
        
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.customerAccessTokenRenew {
                if let accessToken = data.customerAccessToken {
                    let user = AccessToken(from: accessToken)
                    return .success(user)
                } else {
                    let errors = data.userErrors.map { AuthError.GenericError(from: $0) }
                    return .failure(AuthError.Generic(genericErrors: errors))
                }
            } else {
                return .failure(AuthError.Unknown)
            }
        }
    }
    
    func signout() async -> Result<Void, AuthError> {
        guard let token = tokenProvider.accessToken else { return .failure(.Unautherized) }
        let mutation = ShopifyAPI.DeleteCustomerAccessTokenMutation(
            customerAccessToken: token,
            country: .init(nullable: localeProvider.shopifyCountry),
            lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.customerAccessTokenDelete {
                if let _ = data.deletedAccessToken {
                    return .success(Void())
                } else {
                    let errors = data.userErrors.map { AuthError.GenericError(from: $0) }
                    return .failure(AuthError.Generic(genericErrors: errors))
                }
            } else {
                return .failure(AuthError.Unknown)
            }
        }
    }
    
}
