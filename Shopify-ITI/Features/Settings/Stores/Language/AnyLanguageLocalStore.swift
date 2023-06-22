//
//  AnyLanguageLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

protocol AnyLanguageLocalStore: AnyInjectable {
    func read() -> String?
    func write(language: String)
}
