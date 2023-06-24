//
//  OrdersModelTest.swift
//  Shopify-ITI-Tests
//
//  Created by ammar on 24/06/2023.
//

import XCTest
@testable import Shopify_ITI
final class OrdersModelTest: XCTestCase {
    private var remoteService: MockOrdersRemoteService!
    private var model: OrdersModel!

    override func setUp() {
        remoteService = MockOrdersRemoteService()
        let token = AccessTokenProvider()
        model = OrdersModel(remoteService: remoteService, token:token)
    }
    func testLoadCategoriesSuccess() async{
        let order = Order(id: 0, totalPrice: Price(amount: 0, currencyCode: .aed), lineItems: [LineItem(id: "", currentQuantity: 0, originalTotalPrice: Price(amount: 0.0, currencyCode: .afn), variant: ProductVariant(id: "", title: "", image: RemoteImage(id: "", url: "", altText: "", width: 0, height: 0), barcode: "", sku: "", availableForSale: true, price: Price(amount: 0.0, currencyCode: .aed)), product: Product(id: "", handle: "", title: "", vendor: "", description: "", featuredImage: RemoteImage(id: "", url: "", altText: "", width: 0, height: 0), priceRange: PriceRange(minPrice: Price(amount: 0.0, currencyCode: .aed), maxPrice: Price(amount: 0.0, currencyCode: .aed)), variantId: ""))])
        
        remoteService.fetchResult = .success([order,order])
        let res = await model.fetch()
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
        let res = await model.fetch()
        switch(res){
        case .success( _ ):
            XCTFail()
        case .failure(let error):
            XCTAssertNotNil(error)
        }
    }
    

}
