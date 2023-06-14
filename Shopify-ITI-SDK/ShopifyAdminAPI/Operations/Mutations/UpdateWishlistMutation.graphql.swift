// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class UpdateWishlistMutation: GraphQLMutation {
    public static let operationName: String = "updateWishlist"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation updateWishlist($id: ID!, $input: DraftOrderInput!) {
          draftOrderUpdate(id: $id, input: $input) {
            __typename
            draftOrder {
              __typename
              ...wishListInfo
            }
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#,
        fragments: [WishListInfo.self, MoneyInfo.self, PaginationInfo.self]
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
            .fragment(WishListInfo.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAdminAPI.ID { __data["id"] }
          /// The date and time when the draft order was created in Shopify.
          public var createdAt: ShopifyAdminAPI.DateTime { __data["createdAt"] }
          /// The three letter code for the currency of the store at the time of the most recent update to the draft order.
          ///
          public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
          /// The customer who will be sent an invoice for the draft order, if there is one.
          public var customer: WishListInfo.Customer? { __data["customer"] }
          /// A subtotal of the line items and corresponding discounts. The subtotal doesn't include shipping charges, shipping discounts, or taxes.
          public var subtotalPriceSet: WishListInfo.SubtotalPriceSet { __data["subtotalPriceSet"] }
          /// The total amount of the draft order including taxes, shipping charges, and discounts.
          public var totalPriceSet: WishListInfo.TotalPriceSet { __data["totalPriceSet"] }
          /// A comma separated list of tags associated with the draft order. Updating `tags` overwrites
          /// any existing tags that were previously added to the draft order. To add new tags without overwriting
          /// existing tags, use the [tagsAdd](https://shopify.dev/api/admin-graphql/latest/mutations/tagsadd)
          /// mutation.
          ///
          public var tags: [String] { __data["tags"] }
          /// The list of the line items in the draft order.
          public var lineItems: WishListInfo.LineItems { __data["lineItems"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var wishListInfo: WishListInfo { _toFragment() }
          }
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