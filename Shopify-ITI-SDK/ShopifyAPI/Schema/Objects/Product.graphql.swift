// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI.Objects {
  /// A product represents an individual item for sale in a Shopify store. Products are often physical, but they don't have to be.
  /// For example, a digital download (such as a movie, music or ebook file) also qualifies as a product, as do services (such as equipment rental, work for hire, customization of another product or an extended warranty).
  static let Product = Object(
    typename: "Product",
    implementedInterfaces: [
      ShopifyAPI.Interfaces.HasMetafields.self,
      ShopifyAPI.Interfaces.Node.self,
      ShopifyAPI.Interfaces.OnlineStorePublishable.self
    ]
  )
}