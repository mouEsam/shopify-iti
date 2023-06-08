// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  class GetProductByIdQuery: GraphQLQuery {
    static let operationName: String = "getProductById"
    static let document: Apollo.DocumentType = .notPersisted(
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

    struct Data: ShopifyAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      static var __selections: [Apollo.Selection] { [
        .field("product", Product?.self, arguments: ["id": .variable("id")]),
      ] }

      /// Fetch a specific `Product` by one of its unique attributes.
      var product: Product? { __data["product"] }

      /// Product
      ///
      /// Parent Type: `Product`
      struct Product: ShopifyAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
        static var __selections: [Apollo.Selection] { [
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
        var id: ShopifyAPI.ID { __data["id"] }
        /// A human-friendly unique string for the Product automatically generated from its title.
        /// They are used by the Liquid templating language to refer to objects.
        ///
        var handle: String { __data["handle"] }
        /// The product’s title.
        var title: String { __data["title"] }
        /// Stripped description of the product, single line with HTML tags removed.
        var description: String { __data["description"] }
        /// The featured image for the product.
        ///
        /// This field is functionally equivalent to `images(first: 1)`.
        ///
        var featuredImage: FeaturedImage? { __data["featuredImage"] }
        /// Indicates if at least one product variant is available for sale.
        var availableForSale: Bool { __data["availableForSale"] }
        /// The compare at price of the product across all variants.
        var compareAtPriceRange: CompareAtPriceRange { __data["compareAtPriceRange"] }
        /// The metafields associated with the resource matching the supplied list of namespaces and keys.
        ///
        var metafields: [Metafield?] { __data["metafields"] }
        /// The price range.
        var priceRange: PriceRange { __data["priceRange"] }
        /// A comma separated list of tags that have been added to the product.
        /// Additional access scope required for private apps: unauthenticated_read_product_tags.
        ///
        var tags: [String] { __data["tags"] }
        /// The total quantity of inventory in stock for this Product.
        var totalInventory: Int? { __data["totalInventory"] }
        /// The product’s vendor name.
        var vendor: String { __data["vendor"] }
        /// List of product options.
        var options: [Option] { __data["options"] }
        /// List of collections a product belongs to.
        var collections: Collections { __data["collections"] }
        /// List of images associated with the product.
        var images: Images { __data["images"] }
        /// List of the product’s variants.
        var variants: Variants { __data["variants"] }

        /// Product.FeaturedImage
        ///
        /// Parent Type: `Image`
        struct FeaturedImage: ShopifyAPI.SelectionSet {
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

        /// Product.CompareAtPriceRange
        ///
        /// Parent Type: `ProductPriceRange`
        struct CompareAtPriceRange: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(PriceRangeInfo.self),
          ] }

          /// The highest variant's price.
          var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
          /// The lowest variant's price.
          var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var priceRangeInfo: PriceRangeInfo { _toFragment() }
          }

          /// Product.CompareAtPriceRange.MaxVariantPrice
          ///
          /// Parent Type: `MoneyV2`
          struct MaxVariantPrice: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

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

          /// Product.CompareAtPriceRange.MinVariantPrice
          ///
          /// Parent Type: `MoneyV2`
          struct MinVariantPrice: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

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

        /// Product.Metafield
        ///
        /// Parent Type: `Metafield`
        struct Metafield: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Metafield }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(MetafieldInfo.self),
          ] }

          /// A globally-unique ID.
          var id: ShopifyAPI.ID { __data["id"] }
          /// The unique identifier for the metafield within its namespace.
          var key: String { __data["key"] }
          /// The description of a metafield.
          var description: String? { __data["description"] }
          /// The type name of the metafield.
          /// Refer to the list of [supported types](https://shopify.dev/apps/metafields/definitions/types).
          ///
          var type: String { __data["type"] }
          /// The data stored in the metafield. Always stored as a string, regardless of the metafield's type.
          var value: String { __data["value"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var metafieldInfo: MetafieldInfo { _toFragment() }
          }
        }

        /// Product.PriceRange
        ///
        /// Parent Type: `ProductPriceRange`
        struct PriceRange: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(PriceRangeInfo.self),
          ] }

          /// The highest variant's price.
          var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
          /// The lowest variant's price.
          var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var priceRangeInfo: PriceRangeInfo { _toFragment() }
          }

          /// Product.PriceRange.MaxVariantPrice
          ///
          /// Parent Type: `MoneyV2`
          struct MaxVariantPrice: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

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

          /// Product.PriceRange.MinVariantPrice
          ///
          /// Parent Type: `MoneyV2`
          struct MinVariantPrice: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

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

        /// Product.Option
        ///
        /// Parent Type: `ProductOption`
        struct Option: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductOption }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAPI.ID.self),
            .field("name", String.self),
            .field("values", [String].self),
          ] }

          /// A globally-unique ID.
          var id: ShopifyAPI.ID { __data["id"] }
          /// The product option’s name.
          var name: String { __data["name"] }
          /// The corresponding value to the product option name.
          var values: [String] { __data["values"] }
        }

        /// Product.Collections
        ///
        /// Parent Type: `CollectionConnection`
        struct Collections: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CollectionConnection }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of the nodes contained in CollectionEdge.
          var nodes: [Node] { __data["nodes"] }

          /// Product.Collections.Node
          ///
          /// Parent Type: `Collection`
          struct Node: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Collection }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .fragment(CollectionInfo.self),
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

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              var collectionInfo: CollectionInfo { _toFragment() }
            }

            /// Product.Collections.Node.Image
            ///
            /// Parent Type: `Image`
            struct Image: ShopifyAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }

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

        /// Product.Images
        ///
        /// Parent Type: `ImageConnection`
        struct Images: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ImageConnection }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of the nodes contained in ImageEdge.
          var nodes: [Node] { __data["nodes"] }

          /// Product.Images.Node
          ///
          /// Parent Type: `Image`
          struct Node: ShopifyAPI.SelectionSet {
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

        /// Product.Variants
        ///
        /// Parent Type: `ProductVariantConnection`
        struct Variants: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariantConnection }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node].self),
          ] }

          /// A list of the nodes contained in ProductVariantEdge.
          var nodes: [Node] { __data["nodes"] }

          /// Product.Variants.Node
          ///
          /// Parent Type: `ProductVariant`
          struct Node: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .fragment(ProductVariantInfo.self),
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

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              var productVariantInfo: ProductVariantInfo { _toFragment() }
            }

            /// Product.Variants.Node.Image
            ///
            /// Parent Type: `Image`
            struct Image: ShopifyAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Image }

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

            /// Product.Variants.Node.Price
            ///
            /// Parent Type: `MoneyV2`
            struct Price: ShopifyAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }

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
      }
    }
  }

}