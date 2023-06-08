//
//  ProductOption.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation

struct ProductOption: Identifiable {
    let id: String
    let name: String
    let values: [String]
}

protocol ProductOptionConvertible: Identifiable {
    var id: String { get }
    var name: String { get }
    var values: [String] { get }
}

extension ProductOption {
    init(from option: some ProductOptionConvertible) {
        self.init(id: option.id, name: option.name, values: option.values)
    }
}
