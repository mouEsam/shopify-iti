//
//  EmailValidator.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

enum EmailValidationError: String {
    case invalid = "validations.invalid_email"
}

extension EmailValidationError: ValidationError {
    var message: String { rawValue }
}

struct EmailValidator: AnyValidator {
    private static let regexPattern = #"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"#

    private let regex: NSRegularExpression
    
    init() {
        regex = try! NSRegularExpression(pattern: Self.regexPattern, options: .caseInsensitive)
    }
    
    func validate(_ data: String?) -> EmailValidationError? {
        guard let data = data, !data.isEmpty else { return .none }
        let range = NSRange(location: 0, length: data.count)
        let match = regex.firstMatch(in: data, options: [], range: range) != nil
        if match { return .none } else { return .invalid }
    }
}
