//
//  MockWishlistIdLocalStore.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockWishlistIdLocalStore: AnyWishlistIdLocalStore {
    
    var store: AnyWishlistIdLocalStore? = nil
    
    var existsResult: Bool! = nil
    var readResult: Result<String, LocalErrors>! = nil
    var writeResult: Result<Void, LocalErrors>! = nil
    
    func exists() -> Bool {
        if let store = store {
            return store.exists()
        } else {
            return existsResult
        }
    }
    
    func read() -> Result<String, LocalErrors> {
        if let store = store {
            return store.read()
        } else {
            return readResult
        }
    }
    
    func write(id: String) -> Result<Void, LocalErrors> {
        if let store = store {
            return store.write(id: id)
        } else {
            return writeResult
        }
    }
    
    func delete() {
        if let store = store {
            store.delete()
        }
    }
}
