//
//  AnyUserLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyUserLocalStore: AnyInjectable {
    func exists() -> Bool
    func read() -> Result<User, LocalErrors>
    func write(user: User) -> Result<Void, LocalErrors>
    func delete()
}
