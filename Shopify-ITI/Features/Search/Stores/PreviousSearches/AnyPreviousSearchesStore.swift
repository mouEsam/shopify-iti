//
//  AnyPreviousSearchesStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation

protocol AnyPreviousSearchesStore: AnyInjectable {
    func exists() -> Bool
    func read() -> [String]?
    func write(searches: [String])
    func delete()
}
