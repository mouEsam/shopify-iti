//
//  AnyValidator.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol ValidationError: Error {
    var message: String { get }
}

protocol AnyValidator {
    associatedtype Error: ValidationError
    associatedtype T
    
    func validate(_ data: T?) -> Error?
}

extension AnyValidator {
    func canValidate<E>(_ data: E) -> Bool {
        return E.self == T.self
    }
}

class ValidationGroup<T> {
    private var validators: Array<(T) -> ValidationError?> = []
    
    func add<V: AnyValidator>(validator: V) where V.T == T {
        self.validators.append({ validator.validate($0) })
    }
    
    func validate(_ data: T) -> ValidationError? {
        return validators.compactMap { validator in validator(data) }.first
    }
}
