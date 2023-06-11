//
//  ServiceKey.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

public protocol ServiceKeyOption: CustomStringConvertible {
    func isEqualTo(_ another: ServiceKeyOption) -> Bool
    func hash(into: inout Hasher)
}

// MARK: - ServiceKey

internal struct ServiceKey {
    internal let serviceType: Any.Type
    internal let name: String?

    internal init(
        serviceType: Any.Type,
        name: String? = nil
    ) {
        self.serviceType = serviceType
        self.name = name
    }
}

// MARK: Hashable

extension ServiceKey: Hashable {
    public func hash(into hasher: inout Hasher) {
        ObjectIdentifier(serviceType).hash(into: &hasher)
        name?.hash(into: &hasher)
    }
}

// MARK: Equatable

func == (lhs: ServiceKey, rhs: ServiceKey) -> Bool {
    return lhs.serviceType == rhs.serviceType
        && lhs.name == rhs.name
}
