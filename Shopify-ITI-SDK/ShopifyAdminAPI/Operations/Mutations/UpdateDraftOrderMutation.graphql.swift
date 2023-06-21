// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class UpdateDraftOrderMutation: GraphQLMutation {
    public static let operationName: String = "updateDraftOrder"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation updateDraftOrder($id: ID!, $input: DraftOrderInput!) {
          draftOrderUpdate(id: $id, input: $input) {
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

    public var id: ID
    public var input: DraftOrderInput

    public init(
      id: ID,
      input: DraftOrderInput
    ) {
      self.id = id
      self.input = input
    }

    public var __variables: Variables? { [
      "id": id,
      "input": input
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrderUpdate", DraftOrderUpdate?.self, arguments: [
          "id": .variable("id"),
          "input": .variable("input")
        ]),
      ] }

      /// Updates a draft order.
      ///
      /// If a checkout has been started for a draft order, any update to the draft will unlink the checkout. Checkouts
      /// are created but not immediately completed when opening the merchant credit card modal in the admin, and when a
      /// buyer opens the invoice URL. This is usually fine, but there is an edge case where a checkout is in progress
      /// and the draft is updated before the checkout completes. This will not interfere with the checkout and order
      /// creation, but if the link from draft to checkout is broken the draft will remain open even after the order is
      /// created.
      ///
      public var draftOrderUpdate: DraftOrderUpdate? { __data["draftOrderUpdate"] }

      /// DraftOrderUpdate
      ///
      /// Parent Type: `DraftOrderUpdatePayload`
      public struct DraftOrderUpdate: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderUpdatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("draftOrder", DraftOrder?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The updated draft order.
        public var draftOrder: DraftOrder? { __data["draftOrder"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// DraftOrderUpdate.DraftOrder
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

        /// DraftOrderUpdate.UserError
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