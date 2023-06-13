//
//  User.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct User: Identifiable {
    let id: String
    let displayName: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
}

protocol UserConvertible {
    var id: String { get }
    var displayName: String { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var email: String? { get }
    var phone: String? { get }
}

extension User: Codable {}

extension User {
    init(from user: some UserConvertible) {
        self.init(id: user.id,
                  displayName: user.displayName,
                  firstName: user.firstName!,
                  lastName: user.lastName!,
                  email: user.email!,
                  phone: user.phone!)
    }
}

extension ShopifyAPI.CreateCustomerAccountMutation.Data.CustomerCreate.Customer: UserConvertible {}
extension ShopifyAPI.GetCustomerWithAccessTokenQuery.Data.Customer: UserConvertible {}
