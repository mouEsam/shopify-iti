// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI {
  /// The input fields for a cart metafield value to set.
  struct CartInputMetafieldInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      key: String,
      value: String,
      type: String
    ) {
      __data = InputDict([
        "key": key,
        "value": value,
        "type": type
      ])
    }

    /// The key name of the metafield.
    public var key: String {
      get { __data["key"] }
      set { __data["key"] = newValue }
    }

    /// The data to store in the cart metafield. The data is always stored as a string, regardless of the metafield's type.
    ///
    public var value: String {
      get { __data["value"] }
      set { __data["value"] = newValue }
    }

    /// The type of data that the cart metafield stores.
    /// The type of data must be a [supported type](https://shopify.dev/apps/metafields/types).
    ///
    public var type: String {
      get { __data["type"] }
      set { __data["type"] = newValue }
    }
  }

}