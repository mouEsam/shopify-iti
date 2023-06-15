// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  class GetWishlistItemsQuery: GraphQLQuery {
    public static let operationName: String = "getWishlistItems"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getWishlistItems($cursor: String, $count: Int!, $wishlistId: ID!, $context: ContextualPricingContext!) {
          draftOrder(id: $wishlistId) {
            __typename
            lineItems(first: $count, after: $cursor) {
              __typename
              edges {
                __typename
                cursor
                node {
                  __typename
                  ...wishListItemInfo
                  variant {
                    __typename
                    ...productVariantInfo
                    contextualPricing(context: $context) {
                      __typename
                      price {
                        __typename
                        ...moneyInfo
                      }
                    }
                  }
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
        fragments: [WishListItemInfo.self, ImageInfo.self, MoneyInfo.self, ProductInfo.self, PriceRangeInfo.self, ProductVariantInfo.self, PaginationInfo.self]
      ))

    public var cursor: GraphQLNullable<String>
    public var count: Int
    public var wishlistId: ID
    public var context: ContextualPricingContext

    public init(
      cursor: GraphQLNullable<String>,
      count: Int,
      wishlistId: ID,
      context: ContextualPricingContext
    ) {
      self.cursor = cursor
      self.count = count
      self.wishlistId = wishlistId
      self.context = context
    }

    public var __variables: Variables? { [
      "cursor": cursor,
      "count": count,
      "wishlistId": wishlistId,
      "context": context
    ] }

    public struct Data: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("draftOrder", DraftOrder?.self, arguments: ["id": .variable("wishlistId")]),
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
            "first": .variable("count"),
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
            .field("edges", [Edge].self),
            .field("pageInfo", PageInfo.self),
          ] }

          /// A list of edges.
          public var edges: [Edge] { __data["edges"] }
          /// Information to aid in pagination.
          public var pageInfo: PageInfo { __data["pageInfo"] }

          /// DraftOrder.LineItems.Edge
          ///
          /// Parent Type: `DraftOrderLineItemEdge`
          public struct Edge: ShopifyAdminAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItemEdge }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("cursor", String.self),
              .field("node", Node.self),
            ] }

            /// A cursor for use in pagination.
            public var cursor: String { __data["cursor"] }
            /// The item at the end of DraftOrderLineItemEdge.
            public var node: Node { __data["node"] }

            /// DraftOrder.LineItems.Edge.Node
            ///
            /// Parent Type: `DraftOrderLineItem`
            public struct Node: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItem }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("variant", Variant?.self),
                .fragment(WishListItemInfo.self),
              ] }

              /// The associated variant for the line item.
              ///
              public var variant: Variant? { __data["variant"] }
              /// A globally-unique ID.
              public var id: ShopifyAdminAPI.ID { __data["id"] }
              /// The name of the product.
              public var name: String { __data["name"] }
              /// The name of the vendor who created the product variant.
              public var vendor: String? { __data["vendor"] }
              /// The image associated with the draft order line item.
              public var image: Image? { __data["image"] }
              /// The total price (without discounts) of the line item,based on the original unit price of the variant x quantity.
              public var originalTotalSet: WishListItemInfo.OriginalTotalSet { __data["originalTotalSet"] }
              /// The product corresponding to the line item’s product variant.
              ///
              public var product: Product? { __data["product"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var wishListItemInfo: WishListItemInfo { _toFragment() }
              }

              /// DraftOrder.LineItems.Edge.Node.Variant
              ///
              /// Parent Type: `ProductVariant`
              public struct Variant: ShopifyAdminAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductVariant }
                public static var __selections: [Apollo.Selection] { [
                  .field("__typename", String.self),
                  .field("contextualPricing", ContextualPricing.self, arguments: ["context": .variable("context")]),
                  .fragment(ProductVariantInfo.self),
                ] }

                /// The pricing that applies for a customer in a given context.
                public var contextualPricing: ContextualPricing { __data["contextualPricing"] }
                /// A globally-unique ID.
                public var id: ShopifyAdminAPI.ID { __data["id"] }
                /// The title of the product variant.
                public var title: String { __data["title"] }
                /// The featured image for the variant.
                public var image: Image? { __data["image"] }
                /// The value of the barcode associated with the product.
                public var barcode: String? { __data["barcode"] }
                /// A case-sensitive identifier for the product variant in the shop.
                /// Required in order to connect to a fulfillment service.
                ///
                public var sku: String? { __data["sku"] }
                /// Whether the product variant is available for sale.
                public var availableForSale: Bool { __data["availableForSale"] }
                /// The total sellable quantity of the variant.
                public var quantityAvailable: Int? { __data["quantityAvailable"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var productVariantInfo: ProductVariantInfo { _toFragment() }
                }

                /// DraftOrder.LineItems.Edge.Node.Variant.ContextualPricing
                ///
                /// Parent Type: `ProductVariantContextualPricing`
                public struct ContextualPricing: ShopifyAdminAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductVariantContextualPricing }
                  public static var __selections: [Apollo.Selection] { [
                    .field("__typename", String.self),
                    .field("price", Price.self),
                  ] }

                  /// The final price after all adjustments are applied.
                  public var price: Price { __data["price"] }

                  /// DraftOrder.LineItems.Edge.Node.Variant.ContextualPricing.Price
                  ///
                  /// Parent Type: `MoneyV2`
                  public struct Price: ShopifyAdminAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
                    public static var __selections: [Apollo.Selection] { [
                      .field("__typename", String.self),
                      .fragment(MoneyInfo.self),
                    ] }

                    /// Decimal money amount.
                    public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
                    /// Currency of the money.
                    public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(_dataDict: DataDict) { __data = _dataDict }

                      public var moneyInfo: MoneyInfo { _toFragment() }
                    }
                  }
                }
                /// DraftOrder.LineItems.Edge.Node.Variant.Image
                ///
                /// Parent Type: `Image`
                public struct Image: ShopifyAdminAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Image }

                  /// A unique ID for the image.
                  public var id: ShopifyAdminAPI.ID? { __data["id"] }
                  /// The location of the image as a URL.
                  ///
                  /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                  ///
                  /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                  ///
                  /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                  ///
                  public var url: ShopifyAdminAPI.URL { __data["url"] }
                  /// A word or phrase to share the nature or contents of an image.
                  public var altText: String? { __data["altText"] }
                  /// The original width of the image in pixels. Returns `null` if the image is not hosted by Shopify.
                  public var width: Int? { __data["width"] }
                  /// The original height of the image in pixels. Returns `null` if the image is not hosted by Shopify.
                  public var height: Int? { __data["height"] }

                  public struct Fragments: FragmentContainer {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public var imageInfo: ImageInfo { _toFragment() }
                  }
                }
              }
              /// DraftOrder.LineItems.Edge.Node.Image
              ///
              /// Parent Type: `Image`
              public struct Image: ShopifyAdminAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Image }

                /// A unique ID for the image.
                public var id: ShopifyAdminAPI.ID? { __data["id"] }
                /// The location of the image as a URL.
                ///
                /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                ///
                /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                ///
                /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                ///
                public var url: ShopifyAdminAPI.URL { __data["url"] }
                /// A word or phrase to share the nature or contents of an image.
                public var altText: String? { __data["altText"] }
                /// The original width of the image in pixels. Returns `null` if the image is not hosted by Shopify.
                public var width: Int? { __data["width"] }
                /// The original height of the image in pixels. Returns `null` if the image is not hosted by Shopify.
                public var height: Int? { __data["height"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var imageInfo: ImageInfo { _toFragment() }
                }
              }

              /// DraftOrder.LineItems.Edge.Node.Product
              ///
              /// Parent Type: `Product`
              public struct Product: ShopifyAdminAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Product }

                /// A globally-unique ID.
                public var id: ShopifyAdminAPI.ID { __data["id"] }
                /// A unique human-friendly string of the product's title.
                public var handle: String { __data["handle"] }
                /// The title of the product.
                public var title: String { __data["title"] }
                /// A stripped description of the product, single line with HTML tags removed.
                public var description: String { __data["description"] }
                /// The featured image for the product.
                public var featuredImage: FeaturedImage? { __data["featuredImage"] }
                /// The price range of the product.
                @available(*, deprecated, message: "Deprecated in API version 2020-10. Use `priceRangeV2` instead.")
                public var priceRange: PriceRange { __data["priceRange"] }
                /// A list of variants associated with the product.
                public var variants: ProductInfo.Variants { __data["variants"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var productInfo: ProductInfo { _toFragment() }
                }

                /// DraftOrder.LineItems.Edge.Node.Product.FeaturedImage
                ///
                /// Parent Type: `Image`
                public struct FeaturedImage: ShopifyAdminAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Image }

                  /// A unique ID for the image.
                  public var id: ShopifyAdminAPI.ID? { __data["id"] }
                  /// The location of the image as a URL.
                  ///
                  /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                  ///
                  /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                  ///
                  /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                  ///
                  public var url: ShopifyAdminAPI.URL { __data["url"] }
                  /// A word or phrase to share the nature or contents of an image.
                  public var altText: String? { __data["altText"] }
                  /// The original width of the image in pixels. Returns `null` if the image is not hosted by Shopify.
                  public var width: Int? { __data["width"] }
                  /// The original height of the image in pixels. Returns `null` if the image is not hosted by Shopify.
                  public var height: Int? { __data["height"] }

                  public struct Fragments: FragmentContainer {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public var imageInfo: ImageInfo { _toFragment() }
                  }
                }

                /// DraftOrder.LineItems.Edge.Node.Product.PriceRange
                ///
                /// Parent Type: `ProductPriceRange`
                public struct PriceRange: ShopifyAdminAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductPriceRange }

                  /// The highest variant's price.
                  public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
                  /// The lowest variant's price.
                  public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

                  public struct Fragments: FragmentContainer {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public var priceRangeInfo: PriceRangeInfo { _toFragment() }
                  }

                  /// DraftOrder.LineItems.Edge.Node.Product.PriceRange.MaxVariantPrice
                  ///
                  /// Parent Type: `MoneyV2`
                  public struct MaxVariantPrice: ShopifyAdminAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }

                    /// Decimal money amount.
                    public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
                    /// Currency of the money.
                    public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(_dataDict: DataDict) { __data = _dataDict }

                      public var moneyInfo: MoneyInfo { _toFragment() }
                    }
                  }

                  /// DraftOrder.LineItems.Edge.Node.Product.PriceRange.MinVariantPrice
                  ///
                  /// Parent Type: `MoneyV2`
                  public struct MinVariantPrice: ShopifyAdminAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }

                    /// Decimal money amount.
                    public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
                    /// Currency of the money.
                    public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(_dataDict: DataDict) { __data = _dataDict }

                      public var moneyInfo: MoneyInfo { _toFragment() }
                    }
                  }
                }
              }
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