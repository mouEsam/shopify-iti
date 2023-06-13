// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// A market is a group of one or more regions that you want to target for international sales.
  /// By creating a market, you can configure a distinct, localized shopping experience for
  /// customers from a specific area of the world. For example, you can
  /// [change currency](https://shopify.dev/api/admin-graphql/current/mutations/marketCurrencySettingsUpdate),
  /// [configure international pricing](https://shopify.dev/apps/internationalization/product-price-lists),
  /// or [add market-specific domains or subfolders](https://shopify.dev/api/admin-graphql/current/objects/MarketWebPresence).
  ///
  static let Market = Object(
    typename: "Market",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.HasMetafieldDefinitions.self,
      ShopifyAdminAPI.Interfaces.HasMetafields.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}