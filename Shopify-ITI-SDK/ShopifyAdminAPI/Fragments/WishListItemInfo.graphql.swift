// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct WishListItemInfo: ShopifyAdminAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment wishListItemInfo on DraftOrder {
        __typename
        id
        createdAt
        currencyCode
        subtotalPriceSet {
          __typename
          presentmentMoney {
            __typename
            ...moneyInfo
          }
        }
        totalPriceSet {
          __typename
          presentmentMoney {
            __typename
            ...moneyInfo
          }
        }
        tags
        lineItems(first: 1) {
          __typename
          nodes {
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
            variant {
              __typename
              ...productVariantInfo
            }
          }
        }
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrder }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAdminAPI.ID.self),
      .field("createdAt", ShopifyAdminAPI.DateTime.self),
      .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
      .field("subtotalPriceSet", SubtotalPriceSet.self),
      .field("totalPriceSet", TotalPriceSet.self),
      .field("tags", [String].self),
      .field("lineItems", LineItems.self, arguments: ["first": 1]),
    ] }

    /// A globally-unique ID.
    public var id: ShopifyAdminAPI.ID { __data["id"] }
    /// The date and time when the draft order was created in Shopify.
    public var createdAt: ShopifyAdminAPI.DateTime { __data["createdAt"] }
    /// The three letter code for the currency of the store at the time of the most recent update to the draft order.
    ///
    public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
    /// A subtotal of the line items and corresponding discounts. The subtotal doesn't include shipping charges, shipping discounts, or taxes.
    public var subtotalPriceSet: SubtotalPriceSet { __data["subtotalPriceSet"] }
    /// The total amount of the draft order including taxes, shipping charges, and discounts.
    public var totalPriceSet: TotalPriceSet { __data["totalPriceSet"] }
    /// A comma separated list of tags associated with the draft order. Updating `tags` overwrites
    /// any existing tags that were previously added to the draft order. To add new tags without overwriting
    /// existing tags, use the [tagsAdd](https://shopify.dev/api/admin-graphql/latest/mutations/tagsadd)
    /// mutation.
    ///
    public var tags: [String] { __data["tags"] }
    /// The list of the line items in the draft order.
    public var lineItems: LineItems { __data["lineItems"] }

    /// SubtotalPriceSet
    ///
    /// Parent Type: `MoneyBag`
    public struct SubtotalPriceSet: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("presentmentMoney", PresentmentMoney.self),
      ] }

      /// Amount in presentment currency.
      public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

      /// SubtotalPriceSet.PresentmentMoney
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
        public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
        /// Currency of the money.
        public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var moneyInfo: MoneyInfo { _toFragment() }
        }
      }
    }

    /// TotalPriceSet
    ///
    /// Parent Type: `MoneyBag`
    public struct TotalPriceSet: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyBag }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("presentmentMoney", PresentmentMoney.self),
      ] }

      /// Amount in presentment currency.
      public var presentmentMoney: PresentmentMoney { __data["presentmentMoney"] }

      /// TotalPriceSet.PresentmentMoney
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
        public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
        /// Currency of the money.
        public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var moneyInfo: MoneyInfo { _toFragment() }
        }
      }
    }

    /// LineItems
    ///
    /// Parent Type: `DraftOrderLineItemConnection`
    public struct LineItems: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.DraftOrderLineItemConnection }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("nodes", [Node].self),
      ] }

      /// A list of the nodes contained in DraftOrderLineItemEdge.
      public var nodes: [Node] { __data["nodes"] }

      /// LineItems.Node
      ///
      /// Parent Type: `DraftOrderLineItem`
      public struct Node: ShopifyAdminAPI.SelectionSet {
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
          .field("variant", Variant?.self),
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
        /// The associated variant for the line item.
        ///
        public var variant: Variant? { __data["variant"] }

        /// LineItems.Node.Image
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

        /// LineItems.Node.OriginalTotalSet
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

          /// LineItems.Node.OriginalTotalSet.PresentmentMoney
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
            public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
            /// Currency of the money.
            public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var moneyInfo: MoneyInfo { _toFragment() }
            }
          }
        }

        /// LineItems.Node.Product
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
          /// The featured image for the product.
          public var featuredImage: FeaturedImage? { __data["featuredImage"] }
          /// The price range of the product.
          @available(*, deprecated, message: "Deprecated in API version 2020-10. Use `priceRangeV2` instead.")
          public var priceRange: PriceRange { __data["priceRange"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var productInfo: ProductInfo { _toFragment() }
          }

          /// LineItems.Node.Product.FeaturedImage
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

          /// LineItems.Node.Product.PriceRange
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

            /// LineItems.Node.Product.PriceRange.MaxVariantPrice
            ///
            /// Parent Type: `MoneyV2`
            public struct MaxVariantPrice: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }

              /// Decimal money amount.
              public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public var moneyInfo: MoneyInfo { _toFragment() }
              }
            }

            /// LineItems.Node.Product.PriceRange.MinVariantPrice
            ///
            /// Parent Type: `MoneyV2`
            public struct MinVariantPrice: ShopifyAdminAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }

              /// Decimal money amount.
              public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
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

        /// LineItems.Node.Variant
        ///
        /// Parent Type: `ProductVariant`
        public struct Variant: ShopifyAdminAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductVariant }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(ProductVariantInfo.self),
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
          public var inventoryQuantity: Int? { __data["inventoryQuantity"] }
          /// The price of the product variant in the default shop currency.
          public var price: ShopifyAdminAPI.Money { __data["price"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var productVariantInfo: ProductVariantInfo { _toFragment() }
          }

          /// LineItems.Node.Variant.Image
          ///
          /// Parent Type: `Image`
          public struct Image: ShopifyAdminAPI.SelectionSet {
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
        }
      }
    }
  }

}