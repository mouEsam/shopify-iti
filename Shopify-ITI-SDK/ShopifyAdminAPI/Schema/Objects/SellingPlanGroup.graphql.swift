// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// Represents a selling method (for example, "Subscribe and save" or "Pre-paid"). Selling plan groups
  /// and associated records (selling plans and policies) are deleted 48 hours after a merchant
  /// uninstalls their subscriptions app. We recommend backing up these records if you need to restore them later.
  ///
  static let SellingPlanGroup = Object(
    typename: "SellingPlanGroup",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}