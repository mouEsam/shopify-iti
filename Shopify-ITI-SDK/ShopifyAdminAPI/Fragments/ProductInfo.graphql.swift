// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct ProductInfo: ShopifyAdminAPI.SelectionSet, Fragment {
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
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Product }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAdminAPI.ID.self),
      .field("handle", String.self),
      .field("title", String.self),
      .field("description", String.self),
      .field("featuredImage", FeaturedImage?.self),
      .field("priceRange", PriceRange.self),
    ] }

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

    /// FeaturedImage
    ///
    /// Parent Type: `Image`
    public struct FeaturedImage: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Image }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(ImageInfo.self),
      ] }

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

    /// PriceRange
    ///
    /// Parent Type: `ProductPriceRange`
    public struct PriceRange: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductPriceRange }
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

      /// PriceRange.MinVariantPrice
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