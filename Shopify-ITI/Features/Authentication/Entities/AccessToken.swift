//
//  AccessToken.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct AccessToken {
    let accessToken: String
    let expiresAt: Date
}

protocol AccessTokenConvertible {
    associatedtype Expiration
    
    var accessToken: String { get }
    var expiresAt: Expiration { get }
}

extension AccessToken: Codable {}

extension AccessToken {
    var isValid: Bool { expiresAt > Date() }
}

extension AccessToken {
    init<A: AccessTokenConvertible>(from token: A) where A.Expiration == String {
        let dateFormatter = ISO8601DateFormatter()
        self.init(accessToken: token.accessToken,
                  expiresAt: dateFormatter.date(from: token.expiresAt)!)
    }
}

extension ShopifyAPI.CreateCustomerAccessTokenMutation.Data.CustomerAccessTokenCreate.CustomerAccessToken: AccessTokenConvertible {}
extension ShopifyAPI.RenewCustomerAccessTokenMutation.Data.CustomerAccessTokenRenew.CustomerAccessToken: AccessTokenConvertible {}
