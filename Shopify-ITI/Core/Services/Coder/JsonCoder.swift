//
//  JsonCoder.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

struct JsonCoder: AnyDecoder, AnyEncoder {
    static func register(_ container: AppContainer) {
        container.register(type: JsonCoder.self) { resolver in
            JsonCoder()
        }
        .implements((any AnyDecoder).self)
        .implements((any AnyEncoder).self)
    }
    
    func decode<T: Decodable>(target: T.Type, data: Data, userInfo: [CodingUserInfoKey: Any]? = nil, dateFormatter: DateFormatter? = nil) throws -> T {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.userInfo = userInfo ?? [:]
        jsonDecoder.dateDecodingStrategy = dateFormatter.map { .formatted($0) } ?? jsonDecoder.dateDecodingStrategy
        return try jsonDecoder.decode(target, from: data)
    }
    
    func encode<T>(object: T, dateFormatter: DateFormatter?) throws -> Data where T : Encodable {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.dateEncodingStrategy = dateFormatter.map { .formatted($0) } ?? jsonEncoder.dateEncodingStrategy
        return try jsonEncoder.encode(object)
    }
}
