//
//  MetaField.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation

protocol MetaFieldConvertible: Identifiable {
    var id: String { get }
    var key: String { get }
    var description: String? { get }
    var type: String { get }
    var value: String { get }
}

struct MetaField: Identifiable {
    let id: String
    let key: String
    let description: String?
    let type: MetaFieldsType
    let value: String
}

extension MetaField {
    init(from metaField: some MetaFieldConvertible) {
        self.id = metaField.id
        self.key = metaField.key
        self.description = metaField.description
        self.type = MetaFieldsType.init(rawValue: metaField.type)!
        self.value = metaField.value
    }
}
