//
//  Validators.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

enum ValidationErrors: String, ValidationError {
    case required = "required_field" // TODO: Localize
}

struct RequiredValidator<T>: AnyValidator {
    func validate(_ data: T?) -> ValidationErrors? {
        guard let data = data else { return .required }
        if let string = data as? String {
            if string.isEmpty { return .required }
        } else if let list = data as? any Collection {
            if list.isEmpty { return .required }
        }
        return nil
    }
}
