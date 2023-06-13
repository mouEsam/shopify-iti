// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class GetWishlistItemsQuery: GraphQLQuery {
    public static let operationName: String = "getWishlistItems"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getWishlistItems($cursor: String, $count: Int!, $query: String!) {
          draftOrders(after: $cursor, first: $count, query: $query) {
            __typename
            edges {
              __typename
              cursor
              node {
                __typename
                ...wishListItemInfo
              }
            }
            pageInfo {
              __typename
              ...paginationInfo
            }
          }
        }
        """#,
        fragments: [WishListItemInfo.self, MoneyInfo.self, ImageInfo.self, ProductInfo.self, PriceRangeInfo.self, ProductVariantInfo.self, PaginationInfo.self]
      ))

    public var cursor: GraphQLNullable<String>
    public var count: Int
    public var query: String

    public init(
      cursor: GraphQLNullable<String>,
      count: Int,
      query: String
    ) {
      self.cursor = cursor
      self.count = count
      self.query = query
    }

    public var __variables: Variables? { [
      "cursor": cursor,
      "count": count,
      "query": query
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrders", DraftOrders.self, arguments: [
          "after": .variable("cursor"),
          "first": .variable("count"),
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
          .field("edges", [Edge].self),
          .field("pageInfo", PageInfo.self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }
        /// Information to aid in pagination.
        public var pageInfo: PageInfo { __data["pageInfo"] }

        /// DraftOrders.Edge
        ///
        /// Parent Type: `DraftOrderEdge`
        public struct Edge: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderEdge }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("cursor", String.self),
            .field("node", Node.self),
          ] }

          /// A cursor for use in pagination.
          public var cursor: String { __data["cursor"] }
          /// The item at the end of DraftOrderEdge.
          public var node: Node { __data["node"] }

          /// DraftOrders.Edge.Node
          ///
          /// Parent Type: `DraftOrder`
          public struct Node: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .fragment(WishListItemInfo.self),
            ] }

            /// A globally-unique ID.
            public var id: ShopifyAdminAPI.ID { __data["id"] }
            /// The date and time when the draft order was created in Shopify.
            public var createdAt: ShopifyAdminAPI.DateTime { __data["createdAt"] }
            /// The three letter code for the currency of the store at the time of the most recent update to the draft order.
            ///
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
            /// A subtotal of the line items and corresponding discounts. The subtotal doesn't include shipping charges, shipping discounts, or taxes.
            public var subtotalPriceSet: WishListItemInfo.SubtotalPriceSet { __data["subtotalPriceSet"] }
            /// The total amount of the draft order including taxes, shipping charges, and discounts.
            public var totalPriceSet: WishListItemInfo.TotalPriceSet { __data["totalPriceSet"] }
            /// A comma separated list of tags associated with the draft order. Updating `tags` overwrites
            /// any existing tags that were previously added to the draft order. To add new tags without overwriting
            /// existing tags, use the [tagsAdd](https://shopify.dev/api/admin-graphql/latest/mutations/tagsadd)
            /// mutation.
            ///
            public var tags: [String] { __data["tags"] }
            /// The list of the line items in the draft order.
            public var lineItems: WishListItemInfo.LineItems { __data["lineItems"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var wishListItemInfo: WishListItemInfo { _toFragment() }
            }
          }
        }

        /// DraftOrders.PageInfo
        ///
        /// Parent Type: `PageInfo`
        public struct PageInfo: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.PageInfo }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(PaginationInfo.self),
          ] }

          /// The cursor corresponding to the first node in edges.
          public var startCursor: String? { __data["startCursor"] }
          /// The cursor corresponding to the last node in edges.
          public var endCursor: String? { __data["endCursor"] }
          /// Whether there are more pages to fetch following the current page.
          public var hasNextPage: Bool { __data["hasNextPage"] }
          /// Whether there are any pages prior to the current page.
          public var hasPreviousPage: Bool { __data["hasPreviousPage"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var paginationInfo: PaginationInfo { _toFragment() }
          }
        }
      }
    }
  }

}