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
    
    private let serviceType: ServiceType
    private var wrapped: T?
    
    init(serviceType: ServiceType = .automatic) {
        self.serviceType = serviceType
    }
    
    var wrappedValue: T {
        set {
            wrapped = newValue
        }
        get {
            if let value = wrapped {
                return value
            }
            let value = container.require(T.self, serviceType)
            wrapped = value
            return value
        }
    }
}
