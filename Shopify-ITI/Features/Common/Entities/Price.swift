//
//  Price.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation

struct PriceRange {
    let minPrice: Price
    let maxPrice: Price
}

protocol PriceRangeConvertible {
    associatedtype MinVariantPrice: PriceConvertible
    associatedtype MaxVariantPrice: PriceConvertible
    var minVariantPrice: MinVariantPrice { get }
    var maxVariantPrice: MaxVariantPrice { get }
}

extension PriceRange {
    init(from range: some PriceRangeConvertible) {
        self.init(minPrice: Price(from: range.minVariantPrice),
                  maxPrice: Price(from: range.maxVariantPrice))
    }
}

struct Price {
    let amount: Double
    let currencyCode: ShopifyAPI.CurrencyCode
}

protocol PriceConvertible {
    var amount: String { get }
    var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { get }
}

extension Price {
    init(from price: some PriceConvertible) {
        self.init(amount: .init(price.amount)!,
                  currencyCode: price.currencyCode.value!)
    }
}
