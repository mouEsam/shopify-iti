//
//  AnyAccessTokenProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyAccessTokenProvider: AnyInjectable {
    var accessToken: String? { get }
}
