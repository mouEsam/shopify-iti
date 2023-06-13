// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// By default, the Storefront API can't read metafields. To make specific metafields visible in the Storefront API,
  /// you need to create a `MetafieldStorefrontVisibility` record. A `MetafieldStorefrontVisibility` record is a list
  /// of the metafields, defined by the `owner_type`, `namespace`, and `key`, to make visible in the Storefront API.
  ///
  /// Learn about [exposing metafields in the Storefront API]
  /// (https://shopify.dev/custom-storefronts/products-collections/metafields)
  /// for more details.
  ///
  static let MetafieldStorefrontVisibility = Object(
    typename: "MetafieldStorefrontVisibility",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.LegacyInteroperability.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}