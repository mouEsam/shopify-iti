//
//  Injectable.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyInjectable {
    static func register(_ container: AppContainer)
}
