//
//  Price.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import Shopify_Admin_ITI_SDK

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
    associatedtype CurrencyCode: AnyCurrencyCode
    
    var amount: String { get }
    var currencyCode: GraphQLEnum<CurrencyCode> { get }
}

extension Price {
    init(from price: some PriceConvertible) {
        let currencyRawValue = price.currencyCode.value?.rawValue
        let currency = ShopifyAPI.CurrencyCode(rawValue: currencyRawValue!)
        self.init(amount: .init(price.amount)!,
                  currencyCode: currency!)
    }
}

protocol AnyCurrencyCode: EnumType {}

extension ShopifyAPI.CurrencyCode: AnyCurrencyCode {}
extension ShopifyAdminAPI.CurrencyCode: AnyCurrencyCode {}
