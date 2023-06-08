// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  struct ImageInfo: ShopifyAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment imageInfo on Image {
        __typename
        id
        url
        altText
        width
        height
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }
    static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID?.self),
      .field("url", ShopifyAPI.URL.self),
      .field("altText", String?.self),
      .field("width", Int?.self),
      .field("height", Int?.self),
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
  }

}