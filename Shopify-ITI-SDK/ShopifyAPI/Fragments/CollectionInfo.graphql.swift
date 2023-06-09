// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct CollectionInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment collectionInfo on Collection {
        __typename
        id
        handle
        title
        image {
          __typename
          ...imageInfo
        }
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Collection }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("handle", String.self),
      .field("title", String.self),
      .field("image", Image?.self),
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
  }

}