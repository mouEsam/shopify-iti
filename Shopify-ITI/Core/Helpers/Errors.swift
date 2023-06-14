//
//  Errors.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Apollo

enum LocalErrors: Error {
    case NotFound
    case Invalid
    case Unknown
}

enum ShopifyErrors<ErrorCode>: Error {
    case Unknown
    case NotFound
    case Unautherized
    case Client(error: any Error)
    case Validation(validationErrors: [ValidationError<ErrorCode>])
    case Generic(genericErrors: [GenericError])
}

protocol ShopifyError: Error {
    var fields: [String] { get }
    var message: String { get }
}

extension ShopifyErrors {
    struct ValidationError<ErrorCode>: ShopifyError {
        let errorCode: ErrorCode?
        let fields: [String]
        let message: String
    }
}

struct GenericError: ShopifyError {
    let fields: [String]
    let message: String
}

protocol ValidationErrorConvertible {
    associatedtype ErrorCode: EnumType
    
    var code: GraphQLEnum<ErrorCode>? { get }
    var field: [String]? { get }
    var message: String { get }
}

extension ShopifyErrors.ValidationError {
    init<V: ValidationErrorConvertible>(from error: V) where V.ErrorCode == ErrorCode {
        self.init(errorCode: error.code?.value,
                  fields: error.field ?? [],
                  message: error.message)
    }
}

protocol GenericErrorConvertible {
    var field: [String]? { get }
    var message: String { get }
}

extension GenericError {
    init(from error: some GenericErrorConvertible) {
        self.init(fields: error.field ?? [],
                  message: error.message)
    }
}

extension Sequence where Element: GenericErrorConvertible {
    func toShopifyErrors() -> [GenericError] {
        map { GenericError(from: $0) }
    }
}
