//
//  ProductCollection.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation


struct ProductCollection: Identifiable {
    let id: String
    let handle: String
    let title: String
    let image: RemoteImage?
}

protocol ProductCollectionConvertible: Identifiable {
    associatedtype Image: RemoteImageConvertible
    var id: String { get }
    var handle: String { get }
    var title: String { get }
    var image: Image? { get }
}

extension ProductCollection {
    init(from collection: some ProductCollectionConvertible) {
        self.init(id: collection.id,
                  handle: collection.handle,
                  title: collection.title,
                  image: collection.image.map{ RemoteImage(from: $0) })
    }
}
