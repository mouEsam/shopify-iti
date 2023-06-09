// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct MetafieldInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment metafieldInfo on Metafield {
        __typename
        id
        key
        description
        type
        value
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Metafield }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("key", String.self),
      .field("description", String?.self),
      .field("type", String.self),
      .field("value", String.self),
    ] }

    /// A globally-unique ID.
    public var id: ShopifyAPI.ID { __data["id"] }
    /// The unique identifier for the metafield within its namespace.
    public var key: String { __data["key"] }
    /// The description of a metafield.
    public var description: String? { __data["description"] }
    /// The type name of the metafield.
    /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
    ///
    public var type: String { __data["type"] }
    /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
    public var value: String { __data["value"] }
  }

}