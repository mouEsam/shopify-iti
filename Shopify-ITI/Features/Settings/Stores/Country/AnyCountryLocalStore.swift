//
//  AnyCountryLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

protocol AnyCountryLocalStore: AnyInjectable {
    func exists() -> Bool
    func read() -> Result<String, LocalErrors>
    func write(country: String) -> Result<Void, LocalErrors>
    func delete()
}
