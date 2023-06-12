//
//  AnyEncoder.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyEncoder: AnyInjectable {
    func encode<T: Encodable>(object: T, dateFormatter: DateFormatter?) throws -> Data
}

extension AnyEncoder {
    func encode<T: Encodable>(object: T, dateFormatter: DateFormatter? = nil) throws -> Data {
        return try encode(object: object, dateFormatter: dateFormatter)
    }
}

