//
//  UserDefaults.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation

extension UserDefaults: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: UserDefaults.self) { resolver in
                .standard
        }
    }
}
