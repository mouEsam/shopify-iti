//
//  Resource.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

enum Resource<T> {
    case loading
    case none
    case data(data: T)
    case error(error: Error)
}

extension Resource {
    var data: T? {
        if case .data(let data) = self {
            return data
        }
        return nil
    }
}
