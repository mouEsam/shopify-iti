// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class SearchProductsQuery: GraphQLQuery {
    public static let operationName: String = "searchProducts"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query searchProducts($cursor: String, $count: Int!, $query: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          search(first: $count, after: $cursor, query: $query, types: [PRODUCT]) {
            __typename
            edges {
              __typename
              cursor
              node {
                __typename
                ... on Product {
                  ...productInfo
                }
              }
            }
            pageInfo {
              __typename
              ...paginationInfo
            }
          }
        }
        """#,
        fragments: [ProductInfo.self, ImageInfo.self, PriceRangeInfo.self, MoneyInfo.self, PaginationInfo.self]
      ))

    public var cursor: GraphQLNullable<String>
    public var count: Int
    public var query: String
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      cursor: GraphQLNullable<String>,
      count: Int,
      query: String,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.cursor = cursor
      self.count = count
      self.query = query
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "cursor": cursor,
      "count": count,
      "query": query,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("search", Search.self, arguments: [
          "first": .variable("count"),
          "after": .variable("cursor"),
          "query": .variable("query"),
          "types": ["PRODUCT"]
        ]),
      ] }

      /// List of the search results.
      public var search: Search { __data["search"] }

      /// Search
      ///
      /// Parent Type: `SearchResultItemConnection`
      public struct Search: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.SearchResultItemConnection }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
          .field("pageInfo", PageInfo.self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }
        /// Information to aid in pagination.
        public var pageInfo: PageInfo { __data["pageInfo"] }

        /// Search.Edge
        ///
        /// Parent Type: `SearchResultItemEdge`
        public struct Edge: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.SearchResultItemEdge }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("cursor", String.self),
            .field("node", Node.self),
          ] }

          /// A cursor for use in pagination.
          public var cursor: String { __data["cursor"] }
          /// The item at the end of SearchResultItemEdge.
          public var node: Node { __data["node"] }

          /// Search.Edge.Node
          ///
          /// Parent Type: `SearchResultItem`
          public struct Node: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Unions.SearchResultItem }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsProduct.self),
            ] }

            public var asProduct: AsProduct? { _asInlineFragment() }

            /// Search.Edge.Node.AsProduct
            ///
            /// Parent Type: `Product`
            public struct AsProduct: ShopifyAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = SearchProductsQuery.Data.Search.Edge.Node
              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
              public static var __selections: [Apollo.Selection] { [
                .fragment(ProductInfo.self),
              ] }

              /// A globally-unique ID.
              public var id: ShopifyAPI.ID { __data["id"] }
              /// A human-friendly unique string for the Product automatically generated from its title.
              /// They are used by the Liquid templating language to refer to objects.
              ///
              public var handle: String { __data["handle"] }
              /// The product’s title.
              public var title: String { __data["title"] }
              /// Stripped description of the product, single line with HTML tags removed.
              public var description: String { __data["description"] }
              /// The product’s vendor name.
              public var vendor: String { __data["vendor"] }
              /// The featured image for the product.
              ///
              /// This field is functionally equivalent to `images(first: 1)`.
              ///
              public var featuredImage: FeaturedImage? { __data["featuredImage"] }
              /// The price range.
              public var priceRange: PriceRange { __data["priceRange"] }
              /// List of the product’s variants.
              public var variants: ProductInfo.Variants { __data["variants"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var productInfo: ProductInfo { _toFragment() }
              }

              /// Search.Edge.Node.AsProduct.FeaturedImage
              ///
              /// Parent Type: `Image`
              public struct FeaturedImage: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }

                /// A unique ID for the image.
                public var id: ShopifyAPI.ID? { __data["id"] }
                /// The location of the image as a URL.
                ///
                /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
                ///
                /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
                ///
                /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
                ///
                public var url: ShopifyAPI.URL { __data["url"] }
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

              /// Search.Edge.Node.AsProduct.PriceRange
              ///
              /// Parent Type: `ProductPriceRange`
              public struct PriceRange: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }

                /// The highest variant's price.
                public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
                /// The lowest variant's price.
                public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public var priceRangeInfo: PriceRangeInfo { _toFragment() }
                }

                /// Search.Edge.Node.AsProduct.PriceRange.MaxVariantPrice
                ///
                /// Parent Type: `MoneyV2`
                public struct MaxVariantPrice: ShopifyAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

                  /// Decimal money amount.
                  public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  /// Currency of the money.
                  public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }

                  public struct Fragments: FragmentContainer {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public var moneyInfo: MoneyInfo { _toFragment() }
                  }
                }

                /// Search.Edge.Node.AsProduct.PriceRange.MinVariantPrice
                ///
                /// Parent Type: `MoneyV2`
                public struct MinVariantPrice: ShopifyAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

                  /// Decimal money amount.
                  public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  /// Currency of the money.
                  public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }

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

        /// Search.PageInfo
        ///
        /// Parent Type: `PageInfo`
        public struct PageInfo: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.PageInfo }
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