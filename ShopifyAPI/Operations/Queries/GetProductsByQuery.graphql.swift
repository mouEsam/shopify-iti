// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  class GetProductsByQuery: GraphQLQuery {
    static let operationName: String = "getProductsByQuery"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getProductsByQuery($after: String, $first: Int!, $query: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          products(first: $first, after: $after, query: $query) {
            __typename
            edges {
              __typename
              cursor
              node {
                __typename
                id
                handle
                title
                description
                featuredImage {
                  __typename
                  ...imageInfo
                }
                priceRange {
                  __typename
                  ...priceRangeInfo
                }
              }
            }
          }
        }
        """#,
        fragments: [ImageInfo.self, PriceRangeInfo.self, MoneyInfo.self]
      ))

    public var after: GraphQLNullable<String>
    public var first: Int
    public var query: String
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      after: GraphQLNullable<String>,
      first: Int,
      query: String,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.after = after
      self.first = first
      self.query = query
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "after": after,
      "first": first,
      "query": query,
      "country": country,
      "lang": lang
    ] }

    struct Data: ShopifyAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      static var __selections: [Apollo.Selection] { [
        .field("products", Products.self, arguments: [
          "first": .variable("first"),
          "after": .variable("after"),
          "query": .variable("query")
        ]),
      ] }

      /// List of the shop’s products.
      var products: Products { __data["products"] }

      /// Products
      ///
      /// Parent Type: `ProductConnection`
      struct Products: ShopifyAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductConnection }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        var edges: [Edge] { __data["edges"] }

        /// Products.Edge
        ///
        /// Parent Type: `ProductEdge`
        struct Edge: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductEdge }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("cursor", String.self),
            .field("node", Node.self),
          ] }

          /// A cursor for use in pagination.
          var cursor: String { __data["cursor"] }
          /// The item at the end of ProductEdge.
          var node: Node { __data["node"] }

          /// Products.Edge.Node
          ///
          /// Parent Type: `Product`
          struct Node: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("id", ShopifyAPI.ID.self),
              .field("handle", String.self),
              .field("title", String.self),
              .field("description", String.self),
              .field("featuredImage", FeaturedImage?.self),
              .field("priceRange", PriceRange.self),
            ] }

            /// A globally-unique ID.
            var id: ShopifyAPI.ID { __data["id"] }
            /// A human-friendly unique string for the Product automatically generated from its title.
            /// They are used by the Liquid templating language to refer to objects.
            ///
            var handle: String { __data["handle"] }
            /// The product’s title.
            var title: String { __data["title"] }
            /// Stripped description of the product, single line with HTML tags removed.
            var description: String { __data["description"] }
            /// The featured image for the product.
            ///
            /// This field is functionally equivalent to `images(first: 1)`.
            ///
            var featuredImage: FeaturedImage? { __data["featuredImage"] }
            /// The price range.
            var priceRange: PriceRange { __data["priceRange"] }

            /// Products.Edge.Node.FeaturedImage
            ///
            /// Parent Type: `Image`
            struct FeaturedImage: ShopifyAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }
              static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(ImageInfo.self),
              ] }

              /// A unique ID for the image.
              var id: ShopifyAPI.ID? { __data["id"] }
              /// The location of the image as a URL.
              ///
              /// If no transform options are specified, then the original image will be preserved including any pre-applied transforms.
              ///
              /// All transformation options are considered "best-effort". Any transformation that the original image type doesn't support will be ignored.
              ///
              /// If you need multiple variations of the same image, then you can use [GraphQL aliases](https://graphql.org/learn/queries/#aliases).
              ///
              var url: ShopifyAPI.URL { __data["url"] }
              /// A word or phrase to share the nature or contents of an image.
              var altText: String? { __data["altText"] }
              /// The original width of the image in pixels. Returns `null` if the image is not hosted by Shopify.
              var width: Int? { __data["width"] }
              /// The original height of the image in pixels. Returns `null` if the image is not hosted by Shopify.
              var height: Int? { __data["height"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                var imageInfo: ImageInfo { _toFragment() }
              }
            }

            /// Products.Edge.Node.PriceRange
            ///
            /// Parent Type: `ProductPriceRange`
            struct PriceRange: ShopifyAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }
              static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(PriceRangeInfo.self),
              ] }

              /// The highest variant's price.
              var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
              /// The lowest variant's price.
              var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

              struct Fragments: FragmentContainer {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                var priceRangeInfo: PriceRangeInfo { _toFragment() }
              }

              /// Products.Edge.Node.PriceRange.MaxVariantPrice
              ///
              /// Parent Type: `MoneyV2`
              struct MaxVariantPrice: ShopifyAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

                /// Decimal money amount.
                var amount: ShopifyAPI.Decimal { __data["amount"] }
                /// Currency of the money.
                var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }

                struct Fragments: FragmentContainer {
                  let __data: DataDict
                  init(_dataDict: DataDict) { __data = _dataDict }

                  var moneyInfo: MoneyInfo { _toFragment() }
                }
              }

              /// Products.Edge.Node.PriceRange.MinVariantPrice
              ///
              /// Parent Type: `MoneyV2`
              struct MinVariantPrice: ShopifyAPI.SelectionSet {
                let __data: DataDict
                init(_dataDict: DataDict) { __data = _dataDict }

                static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

                /// Decimal money amount.
                var amount: ShopifyAPI.Decimal { __data["amount"] }
                /// Currency of the money.
                var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }

                struct Fragments: FragmentContainer {
                  let __data: DataDict
                  init(_dataDict: DataDict) { __data = _dataDict }

                  var moneyInfo: MoneyInfo { _toFragment() }
                }
              }
            }
          }
        }
      }
    }
  }

}