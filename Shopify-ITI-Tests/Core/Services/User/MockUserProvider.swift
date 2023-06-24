//
//  MockUserProvider.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockUserProvider: AnyUserProvider {
    var provider: AnyUserProvider? = nil
    
    var userResult: Shopify_ITI.User! = nil
    
    var user: User? {
        if let provider = provider {
            return provider.user
        } else {
            return userResult
        }
    }
}
