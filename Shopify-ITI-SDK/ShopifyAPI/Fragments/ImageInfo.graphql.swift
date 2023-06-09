// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct ImageInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment imageInfo on Image {
        __typename
        id
        url
        altText
        width
        height
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID?.self),
      .field("url", ShopifyAPI.URL.self),
      .field("altText", String?.self),
      .field("width", Int?.self),
      .field("height", Int?.self),
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
  }

}