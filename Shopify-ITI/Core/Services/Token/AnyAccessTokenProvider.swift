//
//  AnyAccessTokenProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyAccessTokenProvider {
    var accessToken: String? { get }
}
