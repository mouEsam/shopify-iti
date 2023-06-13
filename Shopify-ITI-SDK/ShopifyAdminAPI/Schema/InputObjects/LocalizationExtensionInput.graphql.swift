// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields for a LocalizationExtensionInput.
  ///
  struct LocalizationExtensionInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      key: GraphQLEnum<LocalizationExtensionKey>,
      value: String
    ) {
      __data = InputDict([
        "key": key,
        "value": value
      ])
    }

    /// The key for the localization extension.
    public var key: GraphQLEnum<LocalizationExtensionKey> {
      get { __data["key"] }
      set { __data["key"] = newValue }
    }

    /// The localization extension value.
    public var value: String {
      get { __data["value"] }
      set { __data["value"] = newValue }
    }
  }

}