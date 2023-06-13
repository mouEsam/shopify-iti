// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// Represents a group of products that can be displayed in online stores and other sales channels in categories, which makes it easy for customers to find them. For example, an athletics store might create different collections for running attire, shoes, and accessories.
  ///
  /// Collections can be defined by conditions, such as whether they match certain product tags. These are called smart or automated collections.
  ///
  /// Collections can also be created for a custom group of products. These are called custom or manual collections.
  ///
  static let Collection = Object(
    typename: "Collection",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.HasMetafieldDefinitions.self,
      ShopifyAdminAPI.Interfaces.HasMetafields.self,
      ShopifyAdminAPI.Interfaces.HasPublishedTranslations.self,
      ShopifyAdminAPI.Interfaces.Node.self,
      ShopifyAdminAPI.Interfaces.Publishable.self
    ]
  )
}