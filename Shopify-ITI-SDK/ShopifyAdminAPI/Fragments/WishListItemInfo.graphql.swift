// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct WishListItemInfo: ShopifyAdminAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment wishListItemInfo on DraftOrderLineItem {
        __typename
        id
        name
        vendor
        image {
          __typename
          ...imageInfo
        }
        originalTotalSet {
          __typename
          presentmentMoney {
            __typename
            ...moneyInfo
          }
        }
        product {
          __typename
          ...productInfo
        }
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItem }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAdminAPI.ID.self),
      .field("name", String.self),
      .field("vendor", String?.self),
      .field("image", Image?.self),
      .field("originalTotalSet", OriginalTotalSet.self),
      .field("product", Product?.self),
    ] }

    /// A globally-unique ID.
    public var id: ShopifyAdminAPI.ID { __data["id"] }
    /// The name of the product.
    public var name: String { __data["name"] }
    /// The name of the vendor who created the product variant.
    public var vendor: String? { __data["vendor"] }
    /// The image associated with the draft order line item.
    public var image: Image? { __data["image"] }
    /// The total price (without discounts) of the line item,based on the original unit price of the variant x quantity.
    public var originalTotalSet: OriginalTotalSet { __data["originalTotalSet"] }
    /// The product corresponding to the line item’s product variant.
    ///
    public var product: Product? { __data["product"] }

    /// Image
    ///
    /// Parent Type: `Image`
    public struct Image: ShopifyAdminAPI.SelectionSet {
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

    /// OriginalTotalSet
    ///
    /// Parent Type: `MoneyBag`
    public struct OriginalTotalSet: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("presentmentMoney", PresentmentMoney.self),
      ] }

      /// Amount in presentment currency.
      public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

      /// OriginalTotalSet.PresentmentMoney
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

    /// Product
    ///
    /// Parent Type: `Product`
    public struct Product: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.Product }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(ProductInfo.self),
      ] }

      /// A globally-unique ID.
      public var id: ShopifyAdminAPI.ID { __data["id"] }
      /// A unique human-friendly string of the product's title.
      public var handle: String { __data["handle"] }
      /// The title of the product.
      public var title: String { __data["title"] }
      /// A stripped description of the product, single line with HTML tags removed.
      public var description: String { __data["description"] }
      /// The name of the product's vendor.
      public var vendor: String { __data["vendor"] }
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

      /// Product.FeaturedImage
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

      /// Product.PriceRange
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

        /// Product.PriceRange.MaxVariantPrice
        ///
        /// Parent Type: `MoneyV2`
        public struct MaxVariantPrice: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }

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

        /// Product.PriceRange.MinVariantPrice
        ///
        /// Parent Type: `MoneyV2`
        public struct MinVariantPrice: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }

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
    }
  }

}