//
//  AnyKeysProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

protocol AnyKeysProvider: AnyInjectable {
    var userLocalKey: String { get }
    var guestLocalKey: String { get }
    var accessTokenLocalKey: String { get }
    var countryLocalKey: String { get }
    var languageLocalKey: String { get }
    var wishlistRemoteKey: String { get }
    var cartRemoteKey: String { get }

}
