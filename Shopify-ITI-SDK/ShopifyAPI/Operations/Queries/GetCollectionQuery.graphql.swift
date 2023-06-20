// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetCollectionQuery: GraphQLQuery {
    public static let operationName: String = "getCollection"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getCollection($name: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          collection(handle: $name) {
            __typename
            products(first: 250) {
              __typename
              nodes {
                __typename
                id
                featuredImage {
                  __typename
                  ...imageInfo
                }
                productType
              }
            }
          }
        }
        """#,
        fragments: [ImageInfo.self]
      ))

    public var name: String
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      name: String,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.name = name
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "name": name,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("collection", Collection?.self, arguments: ["handle": .variable("name")]),
      ] }

      /// Fetch a specific `Collection` by one of its unique attributes.
      public var collection: Collection? { __data["collection"] }

      /// Collection
      ///
      /// Parent Type: `Collection`
      public struct Collection: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Collection }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("products", Products.self, arguments: ["first": 250]),
        ] }

        /// List of products in the collection.
        public var products: Products { __data["products"] }

        /// Collection.Products
        ///
        /// Parent Type: `ProductConnection`
        public struct Products: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductConnection }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of the nodes contained in ProductEdge.
          public var nodes: [Node] { __data["nodes"] }

          /// Collection.Products.Node
          ///
          /// Parent Type: `Product`
          public struct Node: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("id", ShopifyAPI.ID.self),
              .field("featuredImage", FeaturedImage?.self),
              .field("productType", String.self),
            ] }

            /// A globally-unique ID.
            public var id: ShopifyAPI.ID { __data["id"] }
            /// The featured image for the product.
            ///
            /// This field is functionally equivalent to `images(first: 1)`.
            ///
            public var featuredImage: FeaturedImage? { __data["featuredImage"] }
            /// A categorization that a product can be tagged with, commonly used for filtering and searching.
            public var productType: String { __data["productType"] }

            /// Collection.Products.Node.FeaturedImage
            ///
            /// Parent Type: `Image`
            public struct FeaturedImage: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .fragment(ImageInfo.self),
              ] }

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
          }
        }
      }
    }
  }

}