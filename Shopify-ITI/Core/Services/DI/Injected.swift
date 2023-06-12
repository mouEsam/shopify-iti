//
//  Injected.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation
import SwiftUI


@propertyWrapper
class Injected<T>: DynamicProperty {
    @EnvironmentObject private var container: AppContainer
    
    private let name: String?
    private var wrapped: T?
    
    init(name: String? = nil) {
        self.name = name
    }
    
    var wrappedValue: T {
        set {
            wrapped = newValue
        }
        get {
            if let value = wrapped {
                return value
            }
            let value = container.require(T.self, name: name)
            wrapped = value
            return value
        }
    }
}
