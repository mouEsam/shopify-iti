//
//  MockProductModel.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockProductModel: AnyProductModel {
    
    var model: AnyProductModel? = nil
    var fetchResult: Result<SourcedData<DetailedProduct>, ShopifyErrors<Any>>! = nil
    
    func fetch(byId id: String) async -> Result<SourcedData<DetailedProduct>, ShopifyErrors<Any>> {
        if let model = model {
            return await model.fetch(byId: id)
        } else {
            return fetchResult
        }
    }
}
