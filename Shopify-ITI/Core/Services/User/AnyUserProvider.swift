//
//  AnyUserProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation

protocol AnyUserProvider: AnyInjectable {
    var user: User? { get }
}
