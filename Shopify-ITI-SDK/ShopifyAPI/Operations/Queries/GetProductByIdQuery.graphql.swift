// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetProductByIdQuery: GraphQLQuery {
    public static let operationName: String = "getProductById"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getProductById($id: ID!, $collectionsCount: Int!, $imagesCount: Int!, $variantsCount: Int!, $metaFieldsIdentifiers: [HasMetafieldsIdentifier!]!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          product(id: $id) {
            __typename
            id
            handle
            title
            description
            featuredImage {
              __typename
              ...imageInfo
            }
            availableForSale
            compareAtPriceRange {
              __typename
              ...priceRangeInfo
            }
            metafields(identifiers: $metaFieldsIdentifiers) {
              __typename
              ...metafieldInfo
            }
            priceRange {
              __typename
              ...priceRangeInfo
            }
            tags
            totalInventory
            vendor
            options {
              __typename
              id
              name
              values
            }
            collections(first: $collectionsCount) {
              __typename
              nodes {
                __typename
                ...collectionInfo
              }
            }
            images(first: $imagesCount) {
              __typename
              nodes {
                __typename
                ...imageInfo
              }
            }
            variants(first: $variantsCount) {
              __typename
              nodes {
                __typename
                ...productVariantInfo
              }
            }
          }
        }
        """#,
        fragments: [ImageInfo.self, PriceRangeInfo.self, MoneyInfo.self, MetafieldInfo.self, CollectionInfo.self, ProductVariantInfo.self]
      ))

    public var id: ID
    public var collectionsCount: Int
    public var imagesCount: Int
    public var variantsCount: Int
    public var metaFieldsIdentifiers: [HasMetafieldsIdentifier]
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      id: ID,
      collectionsCount: Int,
      imagesCount: Int,
      variantsCount: Int,
      metaFieldsIdentifiers: [HasMetafieldsIdentifier],
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.id = id
      self.collectionsCount = collectionsCount
      self.imagesCount = imagesCount
      self.variantsCount = variantsCount
      self.metaFieldsIdentifiers = metaFieldsIdentifiers
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "id": id,
      "collectionsCount": collectionsCount,
      "imagesCount": imagesCount,
      "variantsCount": variantsCount,
      "metaFieldsIdentifiers": metaFieldsIdentifiers,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("product", Product?.self, arguments: ["id": .variable("id")]),
      ] }

      /// Fetch a specific `Product` by one of its unique attributes.
      public var product: Product? { __data["product"] }

      /// Product
      ///
      /// Parent Type: `Product`
      public struct Product: ShopifyAPI.SelectionSet {
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
          .field("availableForSale", Bool.self),
          .field("compareAtPriceRange", CompareAtPriceRange.self),
          .field("metafields", [Metafield?].self, arguments: ["identifiers": .variable("metaFieldsIdentifiers")]),
          .field("priceRange", PriceRange.self),
          .field("tags", [String].self),
          .field("totalInventory", Int?.self),
          .field("vendor", String.self),
          .field("options", [Option].self),
          .field("collections", Collections.self, arguments: ["first": .variable("collectionsCount")]),
          .field("images", Images.self, arguments: ["first": .variable("imagesCount")]),
          .field("variants", Variants.self, arguments: ["first": .variable("variantsCount")]),
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
        /// Indicates if at least one product variant is available for sale.
        public var availableForSale: Bool { __data["availableForSale"] }
        /// The compare at price of the product across all variants.
        public var compareAtPriceRange: CompareAtPriceRange { __data["compareAtPriceRange"] }
        /// The metafields associated with the resource matching the supplied list of namespaces and keys.
        ///
        public var metafields: [Metafield?] { __data["metafields"] }
        /// The price range.
        public var priceRange: PriceRange { __data["priceRange"] }
        /// A comma separated list of tags that have been added to the product.
        /// Additional access scope required for private apps: unauthenticated_read_product_tags.
        ///
        public var tags: [String] { __data["tags"] }
        /// The total quantity of inventory in stock for this Product.
        public var totalInventory: Int? { __data["totalInventory"] }
        /// The product’s vendor name.
        public var vendor: String { __data["vendor"] }
        /// List of product options.
        public var options: [Option] { __data["options"] }
        /// List of collections a product belongs to.
        public var collections: Collections { __data["collections"] }
        /// List of images associated with the product.
        public var images: Images { __data["images"] }
        /// List of the product’s variants.
        public var variants: Variants { __data["variants"] }

        /// Product.FeaturedImage
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

        /// Product.CompareAtPriceRange
        ///
        /// Parent Type: `ProductPriceRange`
        public struct CompareAtPriceRange: ShopifyAPI.SelectionSet {
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

          /// Product.CompareAtPriceRange.MaxVariantPrice
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

          /// Product.CompareAtPriceRange.MinVariantPrice
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

        /// Product.Metafield
        ///
        /// Parent Type: `Metafield`
        public struct Metafield: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Metafield }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(MetafieldInfo.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// The unique identifier for the metafield within its namespace.
          public var key: String { __data["key"] }
          /// The description of a metafield.
          public var description: String? { __data["description"] }
          /// The type name of the metafield.
          /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
          ///
          public var type: String { __data["type"] }
          /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
          public var value: String { __data["value"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var metafieldInfo: MetafieldInfo { _toFragment() }
          }
        }

        /// Product.PriceRange
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

          /// Product.PriceRange.MaxVariantPrice
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

          /// Product.PriceRange.MinVariantPrice
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

        /// Product.Option
        ///
        /// Parent Type: `ProductOption`
        public struct Option: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductOption }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAPI.ID.self),
            .field("name", String.self),
            .field("values", [String].self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// The product option’s name.
          public var name: String { __data["name"] }
          /// The corresponding value to the product option name.
          public var values: [String] { __data["values"] }
        }

        /// Product.Collections
        ///
        /// Parent Type: `CollectionConnection`
        public struct Collections: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CollectionConnection }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of the nodes contained in CollectionEdge.
          public var nodes: [Node] { __data["nodes"] }

          /// Product.Collections.Node
          ///
          /// Parent Type: `Collection`
          public struct Node: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Collection }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .fragment(CollectionInfo.self),
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

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var collectionInfo: CollectionInfo { _toFragment() }
            }

            /// Product.Collections.Node.Image
            ///
            /// Parent Type: `Image`
            public struct Image: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }

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

        /// Product.Images
        ///
        /// Parent Type: `ImageConnection`
        public struct Images: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ImageConnection }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of the nodes contained in ImageEdge.
          public var nodes: [Node] { __data["nodes"] }

          /// Product.Images.Node
          ///
          /// Parent Type: `Image`
          public struct Node: ShopifyAPI.SelectionSet {
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

        /// Product.Variants
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

          /// Product.Variants.Node
          ///
          /// Parent Type: `ProductVariant`
          public struct Node: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .fragment(ProductVariantInfo.self),
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

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var productVariantInfo: ProductVariantInfo { _toFragment() }
            }

            /// Product.Variants.Node.Image
            ///
            /// Parent Type: `Image`
            public struct Image: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }

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

            /// Product.Variants.Node.Price
            ///
            /// Parent Type: `MoneyV2`
            public struct Price: ShopifyAPI.SelectionSet {
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
        }
      }
    }
  }

}