//
//  AdminEnvironment.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 13/06/2023.
//

import Foundation

// https://18c640d114bd302801f792ba0f7432aa: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@mad43-alex-ios-team1.myshopify.com/admin/api/2023-04/graphql.json

struct AdminEnvironmentProvider: AnyEnvironmentProvider {
    static let diName = "AdminDI"
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyEnvironmentProvider).self,
                           name: diName) { resolver in
            AdminEnvironmentProvider()
        }
    }
    
    let shopifyAccessTokenHeader: String = "X-Shopify-Access-Token"

    let shopifyAccessToken: String = "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"
        
    let shopifyAPIKey: String = "18c640d114bd302801f792ba0f7432aa"
    
    var shopifyBaseUrl: String {
        "https://\(shopifyAPIKey):\(shopifyAccessToken)@mad43-alex-ios-team1.myshopify.com/admin/api/2023-04/graphql.json"
    }
}
