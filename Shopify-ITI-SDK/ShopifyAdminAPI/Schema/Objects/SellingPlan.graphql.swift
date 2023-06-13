// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// Represents how a product can be sold and purchased. Selling plans and associated records (selling plan groups
  /// and policies) are deleted 48 hours after a merchant uninstalls their subscriptions app. We recommend backing
  /// up these records if you need to restore them later.
  ///
  /// For more information on selling plans, refer to
  /// [*Creating and managing selling plans*](https://shopify.dev/docs/apps/selling-strategies/subscriptions/selling-plans).
  ///
  static let SellingPlan = Object(
    typename: "SellingPlan",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}