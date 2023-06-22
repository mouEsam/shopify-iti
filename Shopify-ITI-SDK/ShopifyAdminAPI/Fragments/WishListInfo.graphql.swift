// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct WishListInfo: ShopifyAdminAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment wishListInfo on DraftOrder {
        __typename
        id
        createdAt
        currencyCode
        customer {
          __typename
          id
        }
        subtotalPriceSet {
          __typename
          presentmentMoney {
            __typename
            ...moneyInfo
          }
        }
        totalPriceSet {
          __typename
          presentmentMoney {
            __typename
            ...moneyInfo
          }
        }
        tags
        itemsCount: metafield(key: "lines_count", namespace: "customer_namespace") {
          __typename
          value
        }
        lineItems(first: 250) {
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
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAdminAPI.ID.self),
      .field("createdAt", ShopifyAdminAPI.DateTime.self),
      .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
      .field("customer", Customer?.self),
      .field("subtotalPriceSet", SubtotalPriceSet.self),
      .field("totalPriceSet", TotalPriceSet.self),
      .field("tags", [String].self),
      .field("metafield", alias: "itemsCount", ItemsCount?.self, arguments: [
        "key": "lines_count",
        "namespace": "customer_namespace"
      ]),
      .field("lineItems", LineItems.self, arguments: ["first": 250]),
    ] }

    /// A globally-unique ID.
    public var id: ShopifyAdminAPI.ID { __data["id"] }
    /// The date and time when the draft order was created in Shopify.
    public var createdAt: ShopifyAdminAPI.DateTime { __data["createdAt"] }
    /// The three letter code for the currency of the store at the time of the most recent update to the draft order.
    ///
    public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
    /// The customer who will be sent an invoice for the draft order, if there is one.
    public var customer: Customer? { __data["customer"] }
    /// A subtotal of the line items and corresponding discounts. The subtotal doesn't include shipping charges, shipping discounts, or taxes.
    public var subtotalPriceSet: SubtotalPriceSet { __data["subtotalPriceSet"] }
    /// The total amount of the draft order including taxes, shipping charges, and discounts.
    public var totalPriceSet: TotalPriceSet { __data["totalPriceSet"] }
    /// A comma separated list of tags associated with the draft order. Updating `tags` overwrites
    /// any existing tags that were previously added to the draft order. To add new tags without overwriting
    /// existing tags, use the [tagsAdd](https://shopify.dev/api/admin-graphql/latest/mutations/tagsadd)
    /// mutation.
    ///
    public var tags: [String] { __data["tags"] }
    /// Returns a metafield by namespace and key that belongs to the resource.
    public var itemsCount: ItemsCount? { __data["itemsCount"] }
    /// The list of the line items in the draft order.
    public var lineItems: LineItems { __data["lineItems"] }

    /// Customer
    ///
    /// Parent Type: `Customer`
    public struct Customer: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Customer }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("id", ShopifyAdminAPI.ID.self),
      ] }

      /// A globally-unique ID.
      public var id: ShopifyAdminAPI.ID { __data["id"] }
    }

    /// SubtotalPriceSet
    ///
    /// Parent Type: `MoneyBag`
    public struct SubtotalPriceSet: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("presentmentMoney", PresentmentMoney.self),
      ] }

      /// Amount in presentment currency.
      public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

      /// SubtotalPriceSet.PresentmentMoney
      ///
      /// Parent Type: `MoneyV2`
      public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .fragment(MoneyInfo.self),
        ] }

        /// Decimal money amount.
        public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
        /// Currency of the money.
        public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var moneyInfo: MoneyInfo { _toFragment() }
        }
      }
    }

    /// TotalPriceSet
    ///
    /// Parent Type: `MoneyBag`
    public struct TotalPriceSet: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("presentmentMoney", PresentmentMoney.self),
      ] }

      /// Amount in presentment currency.
      public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

      /// TotalPriceSet.PresentmentMoney
      ///
      /// Parent Type: `MoneyV2`
      public struct PresentmentMoney: ShopifyAdminAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .fragment(MoneyInfo.self),
        ] }

        /// Decimal money amount.
        public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
        /// Currency of the money.
        public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var moneyInfo: MoneyInfo { _toFragment() }
        }
      }
    }

    /// ItemsCount
    ///
    /// Parent Type: `Metafield`
    public struct ItemsCount: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Metafield }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("value", String.self),
      ] }

      /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
      ///
      public var value: String { __data["value"] }
    }

    /// LineItems
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

      /// LineItems.Node
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

        /// LineItems.Node.Product
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

        /// LineItems.Node.Variant
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

      /// LineItems.PageInfo
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