//
//  AnyCountryLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

protocol AnyCountryLocalStore: AnyInjectable {
    func read() -> String?
    func write(country: String)
    func delete()
}
