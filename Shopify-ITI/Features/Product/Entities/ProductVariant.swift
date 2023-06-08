//
//  ProductVariant.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation


struct ProductVariant: Identifiable {
    let id: String
    let title: String
    let image: RemoteImage?
    let barcode: String?
    let sku: String?
    let availableForSale: Bool
    let quantityAvailable: Int?
    let price: Price
}

protocol ProductVariantConvertible: Identifiable {
    associatedtype Image: RemoteImageConvertible
    associatedtype Price: PriceConvertible
    
    var id: String { get }
    var title: String { get }
    var image: Image? { get }
    var barcode: String? { get }
    var sku: String? { get }
    var availableForSale: Bool { get }
    var quantityAvailable: Int? { get }
    var price: Price { get }
}

extension ProductVariant {
    init(from variant: some ProductVariantConvertible) {
        self.init(id: variant.id,
                  title: variant.title,
                  image: variant.image.map { RemoteImage(from: $0) },
                  barcode: variant.barcode,
                  sku: variant.sku,
                  availableForSale: variant.availableForSale,
                  quantityAvailable: variant.quantityAvailable,
                  price: Price(from: variant.price))
    }
}
