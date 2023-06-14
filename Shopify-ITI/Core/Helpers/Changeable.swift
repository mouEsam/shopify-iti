//
//  Changing.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

protocol Changeable {}

extension Changeable {
    func changing<T>(path: WritableKeyPath<Self, T>, to value: T) -> Self {
        var clone = self
        clone[keyPath: path] = value
        return clone
    }
}
