// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct ProductInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment productInfo on Product {
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
        variants(first: 1) {
          __typename
          nodes {
            __typename
            id
          }
        }
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("handle", String.self),
      .field("title", String.self),
      .field("description", String.self),
      .field("featuredImage", FeaturedImage?.self),
      .field("priceRange", PriceRange.self),
      .field("variants", Variants.self, arguments: ["first": 1]),
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
    /// The featured image for the product.
    ///
    /// This field is functionally equivalent to `images(first: 1)`.
    ///
    public var featuredImage: FeaturedImage? { __data["featuredImage"] }
    /// The price range.
    public var priceRange: PriceRange { __data["priceRange"] }
    /// List of the product’s variants.
    public var variants: Variants { __data["variants"] }

    /// FeaturedImage
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

    /// PriceRange
    ///
    /// Parent Type: `ProductPriceRange`
    public struct PriceRange: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(PriceRangeInfo.self),
      ] }

      /// The highest variant's price.
      public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
      /// The lowest variant's price.
      public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var priceRangeInfo: PriceRangeInfo { _toFragment() }
      }

      /// PriceRange.MaxVariantPrice
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

      /// PriceRange.MinVariantPrice
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

    /// Variants
    ///
    /// Parent Type: `ProductVariantConnection`
    public struct Variants: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariantConnection }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("nodes", [Node].self),
      ] }

      /// A list of the nodes contained in ProductVariantEdge.
      public var nodes: [Node] { __data["nodes"] }

      /// Variants.Node
      ///
      /// Parent Type: `ProductVariant`
      public struct Node: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
        ] }

        /// A globally-unique ID.
        public var id: ShopifyAPI.ID { __data["id"] }
      }
    }
  }

}