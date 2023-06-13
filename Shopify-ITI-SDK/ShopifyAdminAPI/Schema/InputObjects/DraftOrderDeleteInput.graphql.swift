// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields to specify the draft order to delete by its ID.
  struct DraftOrderDeleteInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      id: ID
    ) {
      __data = InputDict([
        "id": id
      ])
    }

    /// The ID of the draft order to delete.
    ///
    public var id: ID {
      get { __data["id"] }
      set { __data["id"] = newValue }
    }
  }

}