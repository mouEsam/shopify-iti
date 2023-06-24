//
//  BrandRemoteServiceTest.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import XCTest
@testable import Shopify_ITI

final class BrandRemoteServiceTest: XCTestCase {
    private var remoteService: MockBrandRemoteService!
    private var model: BrandModel!


    override func setUp() {
        remoteService = MockBrandRemoteService()
        model = BrandModel(remoteService: remoteService)
    }

    func testLoadConnectedSuccess() async{
        let brand = ProductCollection(id: "1", handle: "test", title: "test", image: RemoteImage(id: "1", url: "test", altText: "test", width: 123, height: 23))
        remoteService.fetchResult = .success([brand])
        let res = await remoteService.fetch(count: 3)
        switch(res){
        case .success(let data):
            XCTAssertTrue(!data.isEmpty)
        case .failure( _ ):
            XCTFail()
        }
    }
    func testLoadConnectedFailure() async{
        let brand = ProductCollection(id: "1", handle: "test", title: "test", image: RemoteImage(id: "1", url: "test", altText: "test", width: 123, height: 23))
        remoteService.fetchResult = .success([brand])
        let res = await remoteService.fetch(count: 3)
        switch(res){
        case .success(let data):
            XCTAssertTrue(!data.isEmpty)
        case .failure( _ ):
            XCTFail()
        }
    }
    func testLoadNotConnectedSuccess() async{
        let res = await remoteService.fetch(count: 3)
        switch(res){
        case .success(let data):
            XCTAssertNil(data)
        case .failure( _ ):
            XCTFail()
        }
    }
    
    func testLoadConnectedErrorFailure() async{
        let error = 

        let res = await remoteService.fetch(count: 3)
        switch(res){
        case .success(let data):
            XCTAssertNil(data)
        case .failure( _ ):
            XCTFail()
        }
    }
    

}
