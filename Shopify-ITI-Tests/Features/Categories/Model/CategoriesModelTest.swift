//
//  CategoriesModelTest.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import XCTest
@testable import Shopify_ITI
final class CategoriesModelTest: XCTestCase {
    private var remoteService: MockCategoriesRemoteService!
    private var model: CategoriesModel!

    override func setUp() {
        remoteService = MockCategoriesRemoteService()
        model = CategoriesModel(remoteService: remoteService)
    }
    func testLoadCategoriesSuccess() async{
        
        let categories = ProductType(id: "", featuredImage: RemoteImage(id: "", url: "", altText: "", width: 1, height: 1), productType:"")
        
        remoteService.fetchResult = .success([categories])
        let res = await model.fetch(CollectionName: "")
        
        switch(res){
        case .success(let data):
            XCTAssertTrue(!data.isEmpty)
        case .failure( _ ):
            XCTFail()
        }
    }
    
    func testLoadBrandsFailure() async{
        let error = MockError()
        remoteService.fetchResult = .failure(error)
        let res = await model.fetch(CollectionName: "")
        switch(res){
        case .success( _ ):
            XCTFail()
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
    

}
