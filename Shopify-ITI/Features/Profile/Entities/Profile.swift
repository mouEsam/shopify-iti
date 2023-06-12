//
//  Profile.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Shopify_ITI_SDK

extension ShopifyAPI.UpdateCustomerMutation.Data.CustomerUpdate.Customer: UserConvertible {}
extension ShopifyAPI.UpdateCustomerMutation.Data.CustomerUpdate.CustomerAccessToken: AccessTokenConvertible {}
extension ShopifyAPI.UpdateCustomerMutation.Data.CustomerUpdate.CustomerUserError: ValidationErrorConvertible {}
