// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class CreateWishlistItemMutation: GraphQLMutation {
    public static let operationName: String = "createWishlistItem"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation createWishlistItem($input: DraftOrderInput!) {
          draftOrderCreate(input: $input) {
            __typename
            draftOrder {
              __typename
              id
            }
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#
      ))

    public var input: DraftOrderInput

    public init(input: DraftOrderInput) {
      self.input = input
    }

    public var __variables: Variables? { ["input": input] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrderCreate", DraftOrderCreate?.self, arguments: ["input": .variable("input")]),
      ] }

      /// Creates a draft order.
      public var draftOrderCreate: DraftOrderCreate? { __data["draftOrderCreate"] }

      /// DraftOrderCreate
      ///
      /// Parent Type: `DraftOrderCreatePayload`
      public struct DraftOrderCreate: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderCreatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("draftOrder", DraftOrder?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The created draft order.
        ///
        public var draftOrder: DraftOrder? { __data["draftOrder"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// DraftOrderCreate.DraftOrder
        ///
        /// Parent Type: `DraftOrder`
        public struct DraftOrder: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAdminAPI.ID.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAdminAPI.ID { __data["id"] }
        }

        /// DraftOrderCreate.UserError
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