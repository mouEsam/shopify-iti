//
//  MockProductsRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockProductsRemoteService: AnyProductsRemoteService {
    
    var service: AnyProductsRemoteService? = nil
    
    var fetchWithCriterionResult: Result<PageResult<Product>, ProductsError>! = nil
    var fetchWithoutCollectionAndCriterionResult: Result<PageResult<Product>, ProductsError>! = nil
    var fetchWithQueryResult: Result<PageResult<Product>, ProductsError>! = nil
    var fetchWithCollectionResult: Result<PageResult<Product>, ProductsError>! = nil
    
    func fetch(withCriterion criterion: [ProductSearchCriteria : String], count: Int, with paginationInfo: PageInfo?) async -> Result<PageResult<Product>, ProductsError> {
        if let service = service {
            return await service.fetch(withCriterion: criterion, count: count, with: paginationInfo)
        } else {
            return fetchWithCriterionResult
        }
    }
    
    func fetch(withoutCollectionAndCriterion criterion: [ProductSearchCriteria : String], count: Int, with paginationInfo: PageInfo?) async -> Result<PageResult<Product>, ProductsError> {
        if let service = service {
            return await service.fetch(withoutCollectionAndCriterion: criterion, count: count, with: paginationInfo)
        } else {
            return fetchWithoutCollectionAndCriterionResult
        }
    }
    
    func fetch(withQuery query: String, count: Int, with paginationInfo: PageInfo?) async -> Result<PageResult<Product>, ProductsError> {
        if let service = service {
            return await service.fetch(withQuery: query, count: count, with: paginationInfo)
        } else {
            return fetchWithQueryResult
        }
    }
    
    func fetch(withCollection collectionId: String, AndCriterion criterion: [ProductSearchCriteria : String], count: Int, with paginationInfo: PageInfo?) async -> Result<PageResult<Product>, ProductsError> {
        if let service = service {
            return await service.fetch(withCollection: collectionId, AndCriterion: criterion, count: count, with: paginationInfo)
        } else {
            return fetchWithCollectionResult
        }
    }
}
