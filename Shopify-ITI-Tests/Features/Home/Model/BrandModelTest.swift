//
//  BrandModelTest.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import XCTest
@testable import Shopify_ITI

final class BrandModelTest: XCTestCase {
    private var remoteService: MockBrandRemoteService!
    private var model: BrandModel!
    
    
    override func setUp() {
        remoteService = MockBrandRemoteService()
        model = BrandModel(remoteService: remoteService)
    }
    
    func testLoadBrandsSuccess() async{
        let brand = ProductCollection(id: "1", handle: "test", title: "test", image: RemoteImage(id: "1", url: "test", altText: "test", width: 123, height: 23))
        remoteService.fetchResult = .success([brand,brand])
        
        let res = await model.fetch(numberOfItem: 3)
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
        let res = await model.fetch(numberOfItem: 3)
        switch(res){
        case .success( _ ):
            XCTFail()
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }

    
}
    
     
    
    


