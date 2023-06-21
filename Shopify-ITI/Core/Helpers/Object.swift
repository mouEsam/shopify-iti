//
//  Object.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation

struct IdentifiableWrapper: Identifiable {
    var id: String { String(describing: wrapped) }
    let wrapped: Any
}

extension IdentifiableWrapper {
    init?(optional wrapped: Any?) {
        if let wrapped = wrapped {
            self.init(wrapped: wrapped)
        } else {
            return nil
        }
    }
}
