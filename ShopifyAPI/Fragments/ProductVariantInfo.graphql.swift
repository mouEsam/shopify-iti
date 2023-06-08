// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  struct ProductVariantInfo: ShopifyAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
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

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
    static var __selections: [Apollo.Selection] { [
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
    var id: ShopifyAPI.ID { __data["id"] }
    /// The product variant’s title.
    var title: String { __data["title"] }
    /// Image associated with the product variant. This field falls back to the product image if no image is available.
    ///
    var image: Image? { __data["image"] }
    /// The barcode (for example, ISBN, UPC, or GTIN) associated with the variant.
    var barcode: String? { __data["barcode"] }
    /// The SKU (stock keeping unit) associated with the variant.
    var sku: String? { __data["sku"] }
    /// Indicates if the product variant is available for sale.
    var availableForSale: Bool { __data["availableForSale"] }
    /// The total sellable quantity of the variant for online sales channels.
    var quantityAvailable: Int? { __data["quantityAvailable"] }
    /// The product variant’s price.
    var price: Price { __data["price"] }

    /// Image
    ///
    /// Parent Type: `Image`
    struct Image: ShopifyAPI.SelectionSet {
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

    /// Price
    ///
    /// Parent Type: `MoneyV2`
    struct Price: ShopifyAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
      static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(MoneyInfo.self),
      ] }

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