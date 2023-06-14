// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetBrandsQuery: GraphQLQuery {
    public static let operationName: String = "getBrands"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getBrands($first: Int!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          collections(first: $first) {
            __typename
            edges {
              __typename
              node {
                __typename
                ...collectionInfo
              }
            }
          }
        }
        """#,
        fragments: [CollectionInfo.self, ImageInfo.self]
      ))

    public var first: Int
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      first: Int,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.first = first
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "first": first,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("collections", Collections.self, arguments: ["first": .variable("first")]),
      ] }

      /// List of the shop’s collections.
      public var collections: Collections { __data["collections"] }

      /// Collections
      ///
      /// Parent Type: `CollectionConnection`
      public struct Collections: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CollectionConnection }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        public var edges: [Edge] { __data["edges"] }

        /// Collections.Edge
        ///
        /// Parent Type: `CollectionEdge`
        public struct Edge: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CollectionEdge }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of CollectionEdge.
          public var node: Node { __data["node"] }

          /// Collections.Edge.Node
          ///
          /// Parent Type: `Collection`
          public struct Node: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Collection }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .fragment(CollectionInfo.self),
            ] }

            /// A globally-unique ID.
            public var id: ShopifyAPI.ID { __data["id"] }
            /// A human-friendly unique string for the collection automatically generated from its title.
            /// Limit of 255 characters.
            ///
            public var handle: String { __data["handle"] }
            /// The collection’s name. Limit of 255 characters.
            public var title: String { __data["title"] }
            /// Image associated with the collection.
            public var image: Image? { __data["image"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var collectionInfo: CollectionInfo { _toFragment() }
            }

            /// Collections.Edge.Node.Image
            ///
            /// Parent Type: `Image`
            public struct Image: ShopifyAPI.SelectionSet {
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
          }
        }
      }
    }
  }

}