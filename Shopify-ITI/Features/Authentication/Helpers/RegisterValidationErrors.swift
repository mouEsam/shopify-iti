//
//  RegisterValidationErrors.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation

// TODO: localize
enum RegisterValidationErrors: String, ValidationError {
    case invalidConfirmPassword = "invalid_confirm_password"
}
