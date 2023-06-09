// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI {
  /// The input fields to identify a metafield on an owner resource by namespace and key.
  struct HasMetafieldsIdentifier: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      namespace: String,
      key: String
    ) {
      __data = InputDict([
        "namespace": namespace,
        "key": key
      ])
    }

    /// A container for a set of metafields.
    public var namespace: String {
      get { __data["namespace"] }
      set { __data["namespace"] = newValue }
    }

    /// The identifier for the metafield.
    public var key: String {
      get { __data["key"] }
      set { __data["key"] = newValue }
    }
  }

}