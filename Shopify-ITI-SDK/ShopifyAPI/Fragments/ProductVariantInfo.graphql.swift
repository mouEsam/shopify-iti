// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct ProductVariantInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment productVariantInfo on ProductVariant {
        __typename
        id
        title
        image {
          __typename
          ...imageInfo
        }
        barcode
        sku
        availableForSale
        quantityAvailable
        price {
          __typename
          ...moneyInfo
        }
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("title", String.self),
      .field("image", Image?.self),
      .field("barcode", String?.self),
      .field("sku", String?.self),
      .field("availableForSale", Bool.self),
      .field("quantityAvailable", Int?.self),
      .field("price", Price.self),
    ] }

    /// A globally-unique ID.
    public var id: ShopifyAPI.ID { __data["id"] }
    /// The product variant’s title.
    public var title: String { __data["title"] }
    /// Image associated with the product variant. This field falls back to the product image if no image is available.
    ///
    public var image: Image? { __data["image"] }
    /// The barcode (for example, ISBN, UPC, or GTIN) associated with the variant.
    public var barcode: String? { __data["barcode"] }
    /// The SKU (stock keeping unit) associated with the variant.
    public var sku: String? { __data["sku"] }
    /// Indicates if the product variant is available for sale.
    public var availableForSale: Bool { __data["availableForSale"] }
    /// The total sellable quantity of the variant for online sales channels.
    public var quantityAvailable: Int? { __data["quantityAvailable"] }
    /// The product variant’s price.
    public var price: Price { __data["price"] }

    /// Image
    ///
    /// Parent Type: `Image`
    public struct Image: ShopifyAPI.SelectionSet {
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

    /// Price
    ///
    /// Parent Type: `MoneyV2`
    public struct Price: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(MoneyInfo.self),
      ] }

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