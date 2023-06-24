//
//  AnyWishlistIdLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

protocol AnyWishlistIdLocalStore {
    func exists() -> Bool
    func read() -> Result<String, LocalErrors>
    func write(id: String) -> Result<Void, LocalErrors>
    func delete()
}
