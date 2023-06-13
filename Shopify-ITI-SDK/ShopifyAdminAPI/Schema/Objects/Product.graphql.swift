// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// The Product resource lets you manage products in a merchant’s store. You can use [ProductVariants](https://shopify.dev/api/admin-graphql/latest/objects/productvariant) to create or update different versions of the same product. You can also add or update product [Media](https://shopify.dev/api/admin-graphql/latest/interfaces/media). Products can be organized by grouping them into a [Collection](https://shopify.dev/api/admin-graphql/latest/objects/collection).
  static let Product = Object(
    typename: "Product",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.HasMetafieldDefinitions.self,
      ShopifyAdminAPI.Interfaces.HasMetafields.self,
      ShopifyAdminAPI.Interfaces.HasPublishedTranslations.self,
      ShopifyAdminAPI.Interfaces.LegacyInteroperability.self,
      ShopifyAdminAPI.Interfaces.Navigable.self,
      ShopifyAdminAPI.Interfaces.Node.self,
      ShopifyAdminAPI.Interfaces.OnlineStorePreviewable.self,
      ShopifyAdminAPI.Interfaces.Publishable.self
    ]
  )
}