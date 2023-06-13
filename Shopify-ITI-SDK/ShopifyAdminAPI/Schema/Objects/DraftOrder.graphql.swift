// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// An order that a merchant creates on behalf of a customer. Draft orders are useful for merchants that need to do the following tasks:
  ///
  /// - Create new orders for sales made by phone, in person, by chat, or elsewhere. When a merchant accepts payment for a draft order, an order is created.
  /// - Send invoices to customers to pay with a secure checkout link.
  /// - Use custom items to represent additional costs or products that aren't displayed in a shop's inventory.
  /// - Re-create orders manually from active sales channels.
  /// - Sell products at discount or wholesale rates.
  /// - Take pre-orders.
  /// - Save an order as a draft and resume working on it later.
  ///
  /// For Draft orders in multiple currencies `presentment_money` is the source of truth for what a customer is going to be charged and `shop_money` is an estimate of what the merchant might receive in their local currency.
  ///
  /// **Caution:** Only use this data if it's required for your app's functionality. Shopify will restrict [access to scopes](https://shopify.dev/api/usage/access-scopes) for apps that don't have a legitimate use for the associated data.
  ///
  static let DraftOrder = Object(
    typename: "DraftOrder",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.CommentEventSubject.self,
      ShopifyAdminAPI.Interfaces.HasEvents.self,
      ShopifyAdminAPI.Interfaces.HasLocalizationExtensions.self,
      ShopifyAdminAPI.Interfaces.HasMetafields.self,
      ShopifyAdminAPI.Interfaces.LegacyInteroperability.self,
      ShopifyAdminAPI.Interfaces.Navigable.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}