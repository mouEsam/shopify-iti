// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// Represents a price list, including information about related prices and eligibility rules.
  /// You can use price lists to specify either fixed prices or adjusted relative prices that
  /// override initial product variant prices. Price lists are applied to customers
  /// using context rules, which determine price list eligibility.
  ///
  ///   For more information on price lists, refer to
  ///   [Support different pricing models](https://shopify.dev/apps/internationalization/product-price-lists).
  ///
  static let PriceList = Object(
    typename: "PriceList",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}