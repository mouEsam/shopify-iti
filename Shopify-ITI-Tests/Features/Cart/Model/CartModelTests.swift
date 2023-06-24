//
//  CartModelTests.swift
//  Shopify-ITI-Tests
//
//  Created by ahmed alameir on 24/06/2023.
//

import XCTest
@testable import Shopify_ITI_SDK
@testable import Shopify_ITI
final class CartModelTests: XCTestCase {
        var sut: CartModel!
        var mockCartRemoteService: MockCartRemoteService!
        var mockCartIdStore: MockCartIdStore!
    
    private var client: MockRemoteClient!
    private var localeProvider: MockLocaleProvider!
    
        override func setUp() {
            super.setUp()
            mockCartRemoteService = MockCartRemoteService()
            mockCartIdStore = MockCartIdStore()
            sut = CartModel(cartRemoteService: mockCartRemoteService, cartIdStore: mockCartIdStore)
        }

        override func tearDown() {
            mockCartRemoteService = nil
            mockCartIdStore = nil
            sut = nil
            super.tearDown()
        }
    func testGetCart_WhenCartIdExists_ShouldReturnCart() async {
        // Set up the mock cart ID store
        mockCartIdStore.existsReturnValue = true
        mockCartIdStore.readReturnValue = .success("123")
        

        let staticCart = getCart()
        // Set up the mock cart remote service
        let expectedCart = staticCart
        mockCartRemoteService.fetchByIdReturnValue = .success(expectedCart)

        // Call the method to be tested
        let result = await sut.getCart()

        // Assert the expected behavior
        switch(result){
        case .success(let cart):
            XCTAssertTrue(mockCartIdStore.existsCalled)
            XCTAssertTrue(mockCartIdStore.readCalled)
            XCTAssertEqual(staticCart.id, cart.id)

        case .failure(let error):
            XCTFail(error.localizedDescription)

        }
    }
    func testGetCartReal_WhenCartIdExists_ShouldReturnCart() async {
        // Set up the mock cart ID store
       let  localeProvider = MockLocaleProvider()
        localeProvider.countryResult = "EG"
        localeProvider.languageResult = "AR"

        mockCartIdStore.existsReturnValue = true
        mockCartIdStore.readReturnValue = .success("gid://shopify/Cart/c1-be38bcdb89c6def4f4b6ccb4d2d8d9cb")

        mockCartRemoteService.cartRemoteService = CartRemoteService(remoteClient: ApolloGraphQLClient(environment: StorefronEnvironmentProvider()), localeProvider: localeProvider)

        // Set up the mock cart remote service

        // Call the method to be tested
        let result = await sut.getCart()

        // Assert the expected behavior
        switch(result){
        case .success(let cart):
            XCTAssertNotNil(cart)

        case .failure(let error):
            XCTFail(error.localizedDescription)

        }
    }

    func getCart()->Cart{
        let priceRange = PriceRange(minPrice:  Price(amount: 20, currencyCode: .egp), maxPrice:  Price(amount: 20, currencyCode: .egp))
        mockCartIdStore.existsReturnValue = true
        mockCartIdStore.readReturnValue = .success("123")
        let staticCartLine1 = CartLine(
            id: "1",
            quantity: 2,
            productVariant: ProductVariant(id: "3", title: "", image: nil, barcode: nil, sku: nil, availableForSale: true, price: Price(amount: 20, currencyCode: .egp)),
            totalAmount: Price(amount: 20, currencyCode: .egp),
            product: Product(id: "2", handle: "handle", title: "product", vendor: "ad", description: "ds", featuredImage: nil, priceRange: priceRange, variantId: "2")
        )

        let staticCartLine2 = CartLine(
            id: "line123",
            quantity: 1,
            productVariant: ProductVariant(id: "3", title: "", image: nil, barcode: nil, sku: nil, availableForSale: true, price: Price(amount: 20, currencyCode: .egp)),
            totalAmount: Price(amount: 20, currencyCode: .egp),
            product: Product(id: "2", handle: "handle", title: "product", vendor: "ad", description: "ds", featuredImage: nil, priceRange: priceRange, variantId: "2")
        )

        return Cart(
            id: "123",
            userId: "user123",
            cartLine: [staticCartLine1, staticCartLine2],
            subtotalAmount: Price(amount: 20, currencyCode: .egp),
            totalAmount: Price(amount: 20, currencyCode: .egp),
            totalTaxAmount: Price(amount: 20, currencyCode: .egp)
        )
    }


}
