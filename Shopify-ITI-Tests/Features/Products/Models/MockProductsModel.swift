//
//  MockProductsModel.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockProductsModel: AnyProductsModel {
    
    var model: AnyProductsModel? = nil
    var fetchResult: Result<SourcedData<PageResult<Product>>, ShopifyErrors<Any>>! = nil
    
    func fetch(withCriteria criteria: [ProductSearchCriteria : String], with paginationInfo: PageInfo?) async -> Result<SourcedData<PageResult<Product>>, ShopifyErrors<Any>> {
        if let model = model {
            return await model.fetch(withCriteria: criteria, with: paginationInfo)
        } else {
            return fetchResult
        }
    }
}
