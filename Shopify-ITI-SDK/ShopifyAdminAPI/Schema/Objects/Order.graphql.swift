// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// An order is a customer's request to purchase one or more products from a shop. You can retrieve and update orders using the `Order` object.
  /// Learn more about
  /// [editing an existing order with the GraphQL Admin API](https://shopify.dev/apps/fulfillment/order-management-apps/order-editing).
  ///
  /// Only the last 60 days' worth of orders from a store are accessible from the `Order` object by default. If you want to access older orders,
  /// then you need to [request access to all orders](https://shopify.dev/api/usage/access-scopes#orders-permissions). If your app is granted
  /// access, then you can add the `read_all_orders` scope to your app along with `read_orders` or `write_orders`.
  /// [Private apps](https://shopify.dev/apps/auth/basic-http) are not affected by this change and are automatically granted the scope.
  ///
  /// **Caution:** Only use this data if it's required for your app's functionality. Shopify will restrict [access to scopes](https://shopify.dev/api/usage/access-scopes) for apps that don't have a legitimate use for the associated data.
  ///
  static let Order = Object(
    typename: "Order",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.CommentEventSubject.self,
      ShopifyAdminAPI.Interfaces.HasEvents.self,
      ShopifyAdminAPI.Interfaces.HasLocalizationExtensions.self,
      ShopifyAdminAPI.Interfaces.HasMetafieldDefinitions.self,
      ShopifyAdminAPI.Interfaces.HasMetafields.self,
      ShopifyAdminAPI.Interfaces.LegacyInteroperability.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}