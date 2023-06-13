// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// A location or branch of a [company that's a customer](https://shopify.dev/api/admin-graphql/latest/objects/company) of the shop. Configuration of B2B relationship, for example prices lists and checkout settings, may be done for a location.
  static let CompanyLocation = Object(
    typename: "CompanyLocation",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.CommentEventSubject.self,
      ShopifyAdminAPI.Interfaces.HasEvents.self,
      ShopifyAdminAPI.Interfaces.HasMetafieldDefinitions.self,
      ShopifyAdminAPI.Interfaces.HasMetafields.self,
      ShopifyAdminAPI.Interfaces.Navigable.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}