// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class CompleteDraftOrderMutation: GraphQLMutation {
    public static let operationName: String = "completeDraftOrder"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation completeDraftOrder($id: ID!, $paymentPending: Boolean) {
          draftOrderComplete(id: $id, paymentPending: $paymentPending) {
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
    public var paymentPending: GraphQLNullable<Bool>

    public init(
      id: ID,
      paymentPending: GraphQLNullable<Bool>
    ) {
      self.id = id
      self.paymentPending = paymentPending
    }

    public var __variables: Variables? { [
      "id": id,
      "paymentPending": paymentPending
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrderComplete", DraftOrderComplete?.self, arguments: [
          "id": .variable("id"),
          "paymentPending": .variable("paymentPending")
        ]),
      ] }

      /// Completes a draft order and creates an order.
      public var draftOrderComplete: DraftOrderComplete? { __data["draftOrderComplete"] }

      /// DraftOrderComplete
      ///
      /// Parent Type: `DraftOrderCompletePayload`
      public struct DraftOrderComplete: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderCompletePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("draftOrder", DraftOrder?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The completed draft order.
        public var draftOrder: DraftOrder? { __data["draftOrder"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// DraftOrderComplete.DraftOrder
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

        /// DraftOrderComplete.UserError
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