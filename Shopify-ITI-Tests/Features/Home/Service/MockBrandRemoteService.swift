//
//  MockBrandRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI
class MockBrandRemoteService : AnyBrandRemoteService {
    var service : AnyBrandRemoteService? = nil
    var fetchResult: Result<[ProductCollection], Error>? = nil

    func fetch(count: Int) async -> Result<[Shopify_ITI.ProductCollection], Error> {
        if let service = service {
            return await service.fetch(count: count)
        }
        return fetchResult!
    }
    
    
}

