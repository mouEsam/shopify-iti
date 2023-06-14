// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct ProductVariantInfo: ShopifyAdminAPI.SelectionSet, Fragment {
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
        quantityAvailable: inventoryQuantity
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductVariant }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAdminAPI.ID.self),
      .field("title", String.self),
      .field("image", Image?.self),
      .field("barcode", String?.self),
      .field("sku", String?.self),
      .field("availableForSale", Bool.self),
      .field("inventoryQuantity", alias: "quantityAvailable", Int?.self),
    ] }

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
  }

}