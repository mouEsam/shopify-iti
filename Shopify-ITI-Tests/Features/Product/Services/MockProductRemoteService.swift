//
//  MockProductRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockProductRemoteService: AnyProductRemoteService {
    
    var service: AnyProductRemoteService? = nil
    
    var fetchResult: Result<DetailedProduct, ProductError>! = nil
    
    func fetch(byId id: String, collectionsCount: Int, imagesCount: Int, variantsCount: Int) async -> Result<DetailedProduct, ProductError> {
        if let service = service {
            return await service.fetch(byId: id, collectionsCount: collectionsCount, imagesCount: imagesCount, variantsCount: variantsCount)
        } else {
            return fetchResult
        }
    }
}
