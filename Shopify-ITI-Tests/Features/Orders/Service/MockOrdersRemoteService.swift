//
//  MockOrdersRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockOrdersRemoteService: AnyOrdersRemoteService {
    var service : AnyOrdersRemoteService? = nil
    var fetchResult : Result<[Order], Error>? = nil
    func fetch(customerAccessToken token: String) async -> Result<[Order], Error> {
        if let service = service{
            return await service.fetch(customerAccessToken: token)
        }
        return fetchResult!
    }
    
    
}
