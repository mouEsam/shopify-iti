//
//  MockCategoriesRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockCategoriesRemoteService: AnyCategoriesRemoteService {
    var service : AnyCategoriesRemoteService? = nil
    var fetchResult : Result<[ProductType], Error>? = nil
    func fetch(CollectionName name: String) async -> Result<[ProductType], Error> {
        if let service = service{
            return await service.fetch(CollectionName: name)
        }
        return fetchResult!
    }
    
    
}
