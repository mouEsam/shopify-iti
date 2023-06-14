// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class GetWishlistEntriesQuery: GraphQLQuery {
    public static let operationName: String = "getWishlistEntries"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getWishlistEntries($id: ID!, $cursor: String) {
          draftOrder(id: $id) {
            __typename
            lineItems(first: 250, after: $cursor) {
              __typename
              nodes {
                __typename
                product {
                  __typename
                  id
                }
                variant {
                  __typename
                  id
                }
              }
              pageInfo {
                __typename
                ...paginationInfo
              }
            }
          }
        }
        """#,
        fragments: [PaginationInfo.self]
      ))

    public var id: ID
    public var cursor: GraphQLNullable<String>

    public init(
      id: ID,
      cursor: GraphQLNullable<String>
    ) {
      self.id = id
      self.cursor = cursor
    }

    public var __variables: Variables? { [
      "id": id,
      "cursor": cursor
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrder", DraftOrder?.self, arguments: ["id": .variable("id")]),
      ] }

      /// Returns a DraftOrder resource by ID.
      public var draftOrder: DraftOrder? { __data["draftOrder"] }

      /// DraftOrder
      ///
      /// Parent Type: `DraftOrder`
      public struct DraftOrder: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("lineItems", LineItems.self, arguments: [
            "first": 250,
            "after": .variable("cursor")
          ]),
        ] }

        /// The list of the line items in the draft order.
        public var lineItems: LineItems { __data["lineItems"] }

        /// DraftOrder.LineItems
        ///
        /// Parent Type: `DraftOrderLineItemConnection`
        public struct LineItems: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItemConnection }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
            .field("pageInfo", PageInfo.self),
          ] }

          /// A list of the nodes contained in DraftOrderLineItemEdge.
          public var nodes: [Node] { __data["nodes"] }
          /// Information to aid in pagination.
          public var pageInfo: PageInfo { __data["pageInfo"] }

          /// DraftOrder.LineItems.Node
          ///
          /// Parent Type: `DraftOrderLineItem`
          public struct Node: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItem }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("product", Product?.self),
              .field("variant", Variant?.self),
            ] }

            /// The product corresponding to the line item’s product variant.
            ///
            public var product: Product? { __data["product"] }
            /// The associated variant for the line item.
            ///
            public var variant: Variant? { __data["variant"] }

            /// DraftOrder.LineItems.Node.Product
            ///
            /// Parent Type: `Product`
            public struct Product: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Product }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("id", ShopifyAdminAPI.ID.self),
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAdminAPI.ID { __data["id"] }
            }

            /// DraftOrder.LineItems.Node.Variant
            ///
            /// Parent Type: `ProductVariant`
            public struct Variant: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductVariant }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("id", ShopifyAdminAPI.ID.self),
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAdminAPI.ID { __data["id"] }
            }
          }

          /// DraftOrder.LineItems.PageInfo
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

}