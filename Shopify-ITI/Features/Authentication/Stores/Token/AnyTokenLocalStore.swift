//
//  AnyTokenLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyTokenLocalStore: AnyInjectable {
    func exists() -> Bool
    func read() -> Result<AccessToken, LocalErrors>
    func write(token: AccessToken) -> Result<Void, LocalErrors>
    func delete()
}
