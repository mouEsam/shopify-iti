//
//  MockCartIdStore.swift
//  Shopify-ITI-Tests
//
//  Created by ahmed alameir on 24/06/2023.
//

import XCTest
@testable import Shopify_ITI_SDK
@testable import Shopify_ITI
class MockCartIdStore: AnyCartIdStore {
    var existsReturnValue: Bool = false
    var readReturnValue: Result<String, LocalErrors>?
    var writeReturnValue: Result<Void, LocalErrors>?
    
    var existsCalled:Bool = false
    var readCalled:Bool = false
    var writeCalled:Bool = false
    var deleteCalled:Bool = false

    func exists() -> Bool {
        existsCalled = true
        return existsReturnValue
    }

    func read() -> Result<String, LocalErrors> {
        readCalled = true
        return readReturnValue ?? .failure(.NotFound)
    }

    func write(id: String) -> Result<Void, LocalErrors> {
        writeCalled = true
        return writeReturnValue ?? .success(())
    }

    func delete() {
        deleteCalled = true
    }
}
