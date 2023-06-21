//
//  AnyAuthenticationRepository.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

protocol AnyAuthenticationRepository: AnyInjectable {
    func signup(with credentials: SignupCredentials) async -> Result<User, ShopifyErrors<ShopifyAPI.CustomerErrorCode>>
    func login(with credentials: SigninCredentials) async -> Result<Session, Error>
    func recover(email: String) async -> Result<Void, ShopifyErrors<ShopifyAPI.CustomerErrorCode>>
}
