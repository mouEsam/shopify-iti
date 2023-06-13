// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// A reverse delivery is a post-fulfillment object that represents a buyer sending a package to a merchant.
  /// For example, a buyer requests a return, and a merchant sends the buyer a shipping label.
  /// The reverse delivery contains the context of the items sent back, how they're being sent back
  /// (for example, a shipping label), and the current state of the delivery (tracking information).
  ///
  static let ReverseDelivery = Object(
    typename: "ReverseDelivery",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}