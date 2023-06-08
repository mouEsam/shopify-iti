//
//  EnvironmentProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 07/06/2023.
//

import Foundation

struct EnvironmentProvider: AnyEnvironmentProvider {
    
    var shopifyStorefrontAccessToken: String
    
    var shopifyStorefrontAPIKey: String
    
    var shopifyBaseUrl: String {
        "https://\(shopifyStorefrontAPIKey):\(shopifyStorefrontAccessToken)@mad43-alex-ios-team1.myshopify.com/api/2022-01/graphql.json"
    }
    
}
