// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class GetWishlistQuery: GraphQLQuery {
    public static let operationName: String = "getWishlist"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getWishlist($query: String!) {
          draftOrders(first: 1, query: $query) {
            __typename
            nodes {
              __typename
              ...wishListInfo
            }
          }
        }
        """#,
        fragments: [WishListInfo.self, MoneyInfo.self, PaginationInfo.self]
      ))

    public var query: String

    public init(query: String) {
      self.query = query
    }

    public var __variables: Variables? { ["query": query] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrders", DraftOrders.self, arguments: [
          "first": 1,
          "query": .variable("query")
        ]),
      ] }

      /// List of saved draft orders.
      public var draftOrders: DraftOrders { __data["draftOrders"] }

      /// DraftOrders
      ///
      /// Parent Type: `DraftOrderConnection`
      public struct DraftOrders: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderConnection }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("nodes", [Node].self),
        ] }

        /// A list of the nodes contained in DraftOrderEdge.
        public var nodes: [Node] { __data["nodes"] }

        /// DraftOrders.Node
        ///
        /// Parent Type: `DraftOrder`
        public struct Node: ShopifyAdminAPI.SelectionSet {
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
      }
    }
  }

}