// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// Represents a fulfillment.
  /// In Shopify, a fulfillment represents a shipment of one or more items in an order.
  /// When an order has been completely fulfilled, it means that all the items that are included
  /// in the order have been sent to the customer.
  /// There can be more than one fulfillment for an order.
  ///
  static let Fulfillment = Object(
    typename: "Fulfillment",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.LegacyInteroperability.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}