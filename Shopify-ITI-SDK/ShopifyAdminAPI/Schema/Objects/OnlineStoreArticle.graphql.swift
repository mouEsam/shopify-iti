// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// An article in the blogging system. You can query articles from
  /// [the REST API](https://shopify.dev/api/admin-rest/latest/resources/article)
  /// if you need to access more information about an article. Currently, `OnlineStoreArticle` is
  /// only useful to pass an article `id` to the `tagsAdd` mutation. For more information, refer to
  /// the [tagsAdd](https://shopify.dev/api/admin-graphql/latest/mutations/tagsadd) mutation.
  ///
  static let OnlineStoreArticle = Object(
    typename: "OnlineStoreArticle",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.HasPublishedTranslations.self,
      ShopifyAdminAPI.Interfaces.Navigable.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}