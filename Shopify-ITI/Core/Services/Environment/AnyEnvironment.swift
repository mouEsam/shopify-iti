//
//  Environment.swift
//  BallPark
//
//  Created by Mostafa Ibrahim on 26/05/2023.
//

import Foundation

protocol AnyEnvironmentProvider: AnyInjectable {
    var shopifyAccessToken: String { get }
    var shopifyAccessTokenHeader: String { get }
    var shopifyBaseUrl: String { get }
}
