// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class DeleteWishlistItemMutation: GraphQLMutation {
    public static let operationName: String = "deleteWishlistItem"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation deleteWishlistItem($input: DraftOrderDeleteInput!) {
          draftOrderDelete(input: $input) {
            __typename
            deletedId
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#
      ))

    public var input: DraftOrderDeleteInput

    public init(input: DraftOrderDeleteInput) {
      self.input = input
    }

    public var __variables: Variables? { ["input": input] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrderDelete", DraftOrderDelete?.self, arguments: ["input": .variable("input")]),
      ] }

      /// Deletes a draft order.
      public var draftOrderDelete: DraftOrderDelete? { __data["draftOrderDelete"] }

      /// DraftOrderDelete
      ///
      /// Parent Type: `DraftOrderDeletePayload`
      public struct DraftOrderDelete: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderDeletePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("deletedId", ShopifyAdminAPI.ID?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The ID of the deleted draft order.
        ///
        public var deletedId: ShopifyAdminAPI.ID? { __data["deletedId"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// DraftOrderDelete.UserError
        ///
        /// Parent Type: `UserError`
        public struct UserError: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.UserError }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("field", [String]?.self),
            .field("message", String.self),
          ] }

          /// The path to the input field that caused the error.
          public var field: [String]? { __data["field"] }
          /// The error message.
          public var message: String { __data["message"] }
        }
      }
    }
  }

}