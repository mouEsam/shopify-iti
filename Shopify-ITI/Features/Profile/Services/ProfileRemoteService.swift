//
//  ProfileRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct ProfileRemoteService: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: ProfileRemoteService.self) { resolver in
            ProfileRemoteService(client: resolver.require((any GraphQLClient).self),
                                 localeProvider: resolver.require((any AnyLocaleProvider).self),
                                 tokenProvider: resolver.require((any AnyAccessTokenProvider).self))
        }
    }
    
    typealias ProfileError = ShopifyErrors<ShopifyAPI.CustomerErrorCode>
    
    private let client: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    private let tokenProvider: any AnyAccessTokenProvider
    
    init(client: some GraphQLClient,
         localeProvider: some AnyLocaleProvider,
         tokenProvider: some AnyAccessTokenProvider) {
        self.client = client
        self.localeProvider = localeProvider
        self.tokenProvider = tokenProvider
    }
    
    func profile() async -> Result<User, ProfileError> {
        guard let token = tokenProvider.accessToken else { return .failure(.Unautherized) }
        return await profile(for: token)
    }
    
    func profile(for accessToken: String) async -> Result<User, ProfileError> {
        let query = ShopifyAPI.GetCustomerWithAccessTokenQuery(customerAccessToken: accessToken,
                                                               country: .init(nullable: localeProvider.shopifyCountry),
                                                               lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data {
                if let user = data.customer {
                    let user = User(from: user)
                    return .success(user)
                } else {
                    return .failure(ProfileError.NotFound)
                }
            } else {
                return .failure(ProfileError.Unknown)
            }
        }
    }
    
    func update(with newProfile: ProfileUpdate) async -> Result<Session, ProfileError> {
        guard let token = tokenProvider.accessToken else { return .failure(.Unautherized) }
        let input = ShopifyAPI.CustomerUpdateInput(firstName: .init(nullable: newProfile.firstName),
                                                   lastName: .init(nullable: newProfile.lastName),
                                                   email: .init(nullable: newProfile.email),
                                                   phone: .init(nullable: newProfile.phone),
                                                   password: .init(nullable: newProfile.password))
        let mutation = ShopifyAPI.UpdateCustomerMutation(customerAccessToken: token,
                                                         customer: input,
                                                         country: .init(nullable: localeProvider.shopifyCountry),
                                                         lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await client.execute(query: mutation)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let data = result.data?.customerUpdate {
                if let user = data.customer,
                   let accessToken = data.customerAccessToken {
                    let user = User(from: user)
                    let token = AccessToken(from: accessToken)
                    return .success(Session(user: user, accessToken: token))
                } else {
                    let errors = data.customerUserErrors.map { ProfileError.ValidationError(from: $0) }
                    return .failure(ProfileError.Validation(validationErrors: errors))
                }
            } else {
                return .failure(ProfileError.Unknown)
            }
        }
    }
}
