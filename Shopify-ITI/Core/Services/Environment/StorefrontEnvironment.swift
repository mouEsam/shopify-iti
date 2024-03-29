//
//  EnvironmentProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation

// https://18c640d114bd302801f792ba0f7432aa:74fc3fc4ffb7889a033a7ab71b34499d@mad43-alex-ios-team1.myshopify.com/api/2023-07/graphql.json

struct StorefronEnvironmentProvider: AnyEnvironmentProvider, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyEnvironmentProvider).self) { resolver in
            StorefronEnvironmentProvider()
        }
    }
    
    let shopifyAccessTokenHeader: String = "X-Shopify-Storefront-Access-Token"

    let shopifyAccessToken: String = "74fc3fc4ffb7889a033a7ab71b34499d"
        
    let shopifyAPIKey: String = "18c640d114bd302801f792ba0f7432aa"
    
    var shopifyBaseUrl: String {
        "https://\(shopifyAPIKey):\(shopifyAccessToken)@mad43-alex-ios-team1.myshopify.com/api/2023-07/graphql.json"
    }
}
