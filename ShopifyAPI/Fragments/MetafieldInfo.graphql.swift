// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  struct MetafieldInfo: ShopifyAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment metafieldInfo on Metafield {
        __typename
        id
        key
        description
        type
        value
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Metafield }
    static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("key", String.self),
      .field("description", String?.self),
      .field("type", String.self),
      .field("value", String.self),
    ] }

    /// A globally-unique ID.
    var id: ShopifyAPI.ID { __data["id"] }
    /// The unique identifier for the metafield within its namespace.
    var key: String { __data["key"] }
    /// The description of a metafield.
    var description: String? { __data["description"] }
    /// The type name of the metafield.
    /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
    ///
    var type: String { __data["type"] }
    /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
    var value: String { __data["value"] }
  }

}