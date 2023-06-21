//
//  RegisterValidationErrors.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation

// TODO: localize
enum RegisterValidationErrors: String {
    case invalidConfirmPassword = "validations.invalid_confirm_password"
}

extension RegisterValidationErrors: ValidationError{
    var message: String { rawValue }
}
