//
//  AnyGuestLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyGuestLocalStore: AnyInjectable {
    func exists() -> Bool
    func read() -> Result<Guest, LocalErrors>
    func write(guest: Guest) -> Result<Void, LocalErrors>
    func delete()
}
