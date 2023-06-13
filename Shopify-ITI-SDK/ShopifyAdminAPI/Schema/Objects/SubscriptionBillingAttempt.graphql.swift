// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// A record of an execution of the subscription billing process. Billing attempts use
  /// idempotency keys to avoid duplicate order creation. A successful billing attempt
  /// will create an order.
  ///
  static let SubscriptionBillingAttempt = Object(
    typename: "SubscriptionBillingAttempt",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}