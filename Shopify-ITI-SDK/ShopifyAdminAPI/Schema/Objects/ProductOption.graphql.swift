// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// The product property names. For example, "Size", "Color", and "Material".
  /// Variants are selected based on permutations of these options.
  /// The limit for each product property name is 255 characters.
  ///
  static let ProductOption = Object(
    typename: "ProductOption",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.HasPublishedTranslations.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}