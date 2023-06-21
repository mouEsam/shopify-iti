//
//  Validators.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

enum ValidationErrors: String {
    case required = "validations.required_field"
    case invalid = "validations.invalid_field"
}

extension ValidationErrors: ValidationError {
    var message: String { rawValue }
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

struct ValueValidator<T, Error: ValidationError>: AnyValidator {
    
    private let validator: (T?) -> Error?
    
    init(validator: @escaping (T?) -> Error?) {
        self.validator = validator
    }
    
    func validate(_ data: T?) -> Error? {
        return validator(data)
    }
}
