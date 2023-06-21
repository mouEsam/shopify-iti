//
//  Error.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Apollo
import Shopify_ITI_SDK

extension ShopifyAPI.CreateCustomerAccountMutation.Data.CustomerCreate.CustomerUserError: ValidationErrorConvertible {}
extension ShopifyAPI.CreateCustomerAccessTokenMutation.Data.CustomerAccessTokenCreate.CustomerUserError: ValidationErrorConvertible {}
extension ShopifyAPI.RecoverCustomerAccountMutation.Data.CustomerRecover.CustomerUserError: ValidationErrorConvertible {}
extension ShopifyAPI.RenewCustomerAccessTokenMutation.Data.CustomerAccessTokenRenew.UserError: GenericErrorConvertible {}
extension ShopifyAPI.DeleteCustomerAccessTokenMutation.Data.CustomerAccessTokenDelete.UserError: GenericErrorConvertible {}
