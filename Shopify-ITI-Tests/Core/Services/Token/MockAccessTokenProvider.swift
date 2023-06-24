//
//  MockAccessTokenProvider.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class AccessTokenProvider: AnyAccessTokenProvider {
    
    var provider: AnyAccessTokenProvider? = nil
    var accessTokenResult: String! = nil
    
    var accessToken: String? {
        if let provider = provider {
            return provider.accessToken
        } else {
            return accessTokenResult
        }
    }
}
