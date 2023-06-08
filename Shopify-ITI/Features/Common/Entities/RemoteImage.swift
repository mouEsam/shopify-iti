//
//  RemoteImage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

struct RemoteImage: Identifiable {
    let id: String?
    let url: String
    let altText: String?
    let width: Int?
    let height: Int?
}

protocol RemoteImageConvertible: Identifiable {
    var id: String? { get }
    var url: String { get }
    var altText: String? { get }
    var width: Int? { get }
    var height: Int? { get }
}

extension RemoteImage {
    init(from image: some RemoteImageConvertible) {
        self.init(id: image.id,
                  url: image.url,
                  altText: image.altText,
                  width: image.width,
                  height: image.height)
    }
}
