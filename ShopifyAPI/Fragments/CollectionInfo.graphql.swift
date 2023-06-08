// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  struct CollectionInfo: ShopifyAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
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

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Collection }
    static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("handle", String.self),
      .field("title", String.self),
      .field("image", Image?.self),
    ] }

    /// A globally-unique ID.
    var id: ShopifyAPI.ID { __data["id"] }
    /// A human-friendly unique string for the collection automatically generated from its title.
    /// Limit of 255 characters.
    ///
    var handle: String { __data["handle"] }
    /// The collection’s name. Limit of 255 characters.
    var title: String { __data["title"] }
    /// Image associated with the collection.
    var image: Image? { __data["image"] }

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
  }

}