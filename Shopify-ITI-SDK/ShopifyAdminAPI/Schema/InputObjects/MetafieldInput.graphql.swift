// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields to use to create or update a metafield through a mutation on the owning resource.
  /// An alternative way to create or update a metafield is by using the
  /// [metafieldsSet](https://shopify.dev/api/admin-graphql/latest/mutations/metafieldsSet) mutation.
  ///
  struct MetafieldInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      id: GraphQLNullable<ID> = nil,
      namespace: GraphQLNullable<String> = nil,
      key: GraphQLNullable<String> = nil,
      value: GraphQLNullable<String> = nil,
      type: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "id": id,
        "namespace": namespace,
        "key": key,
        "value": value,
        "type": type
      ])
    }

    /// The unique ID of the metafield.
    ///
    /// Required when updating a metafield, but should not be included when creating as it's created automatically.
    ///
    public var id: GraphQLNullable<ID> {
      get { __data["id"] }
      set { __data["id"] = newValue }
    }

    /// The container for a group of metafields that the metafield is or will be associated with. Used in tandem with
    /// `key` to lookup a metafield on a resource, preventing conflicts with other metafields with the same `key`.
    ///
    /// Required when creating a metafield, but optional when updating. Used to help identify the metafield when
    /// updating, but cannot be updated itself.
    ///
    /// Must be 3-255 characters long and can contain alphanumeric, hyphen, and underscore characters.
    ///
    public var namespace: GraphQLNullable<String> {
      get { __data["namespace"] }
      set { __data["namespace"] = newValue }
    }

    /// The unique identifier for a metafield within its namespace.
    ///
    /// Required when creating a metafield, but optional when updating. Used to help identify the metafield when
    /// updating, but cannot be updated itself.
    ///
    /// Must be 3-64 characters long and can contain alphanumeric, hyphen, and underscore characters.
    ///
    public var key: GraphQLNullable<String> {
      get { __data["key"] }
      set { __data["key"] = newValue }
    }

    /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
    ///
    public var value: GraphQLNullable<String> {
      get { __data["value"] }
      set { __data["value"] = newValue }
    }

    /// The type of data that is stored in the metafield.
    /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/types).
    ///
    /// Required when creating a metafield, but optional when updating.
    ///
    public var type: GraphQLNullable<String> {
      get { __data["type"] }
      set { __data["type"] = newValue }
    }
  }

}