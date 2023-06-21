// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetOrdersQuery: GraphQLQuery {
    public static let operationName: String = "getOrders"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getOrders($customerAccessToken: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customer(customerAccessToken: $customerAccessToken) {
            __typename
            orders(first: 200) {
              __typename
              edges {
                __typename
                node {
                  __typename
                  orderNumber
                  totalPrice {
                    __typename
                    ...moneyInfo
                  }
                  lineItems(first: 200) {
                    __typename
                    edges {
                      __typename
                      node {
                        __typename
                        title
                        currentQuantity
                        originalTotalPrice {
                          __typename
                          ...moneyInfo
                        }
                        variant {
                          __typename
                          ...productVariantInfo
                          product {
                            __typename
                            ...productInfo
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        """#,
        fragments: [MoneyInfo.self, ProductVariantInfo.self, ImageInfo.self, ProductInfo.self, PriceRangeInfo.self]
      ))

    public var customerAccessToken: String
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      customerAccessToken: String,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.customerAccessToken = customerAccessToken
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "customerAccessToken": customerAccessToken,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("customer", Customer?.self, arguments: ["customerAccessToken": .variable("customerAccessToken")]),
      ] }

      /// The customer associated with the given access token. Tokens are obtained by using the
      /// [`customerAccessTokenCreate` mutation](https://shopify.dev/docs/api/storefront/latest/mutations/customerAccessTokenCreate).
      ///
      public var customer: Customer? { __data["customer"] }

      /// Customer
      ///
      /// Parent Type: `Customer`
      public struct Customer: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Customer }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("orders", Orders.self, arguments: ["first": 200]),
        ] }

        /// The orders associated with the customer.
        public var orders: Orders { __data["orders"] }

        /// Customer.Orders
        ///
        /// Parent Type: `OrderConnection`
        public struct Orders: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.OrderConnection }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("edges", [Edge].self),
          ] }

          /// A list of edges.
          public var edges: [Edge] { __data["edges"] }

          /// Customer.Orders.Edge
          ///
          /// Parent Type: `OrderEdge`
          public struct Edge: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.OrderEdge }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("node", Node.self),
            ] }

            /// The item at the end of OrderEdge.
            public var node: Node { __data["node"] }

            /// Customer.Orders.Edge.Node
            ///
            /// Parent Type: `Order`
            public struct Node: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Order }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("orderNumber", Int.self),
                .field("totalPrice", TotalPrice.self),
                .field("lineItems", LineItems.self, arguments: ["first": 200]),
              ] }

              /// A unique numeric identifier for the order for use by shop owner and customer.
              public var orderNumber: Int { __data["orderNumber"] }
              /// The sum of all the prices of all the items in the order, duties, taxes and discounts included (must be positive).
              public var totalPrice: TotalPrice { __data["totalPrice"] }
              /// List of the order’s line items.
              public var lineItems: LineItems { __data["lineItems"] }

              /// Customer.Orders.Edge.Node.TotalPrice
              ///
              /// Parent Type: `MoneyV2`
              public struct TotalPrice: ShopifyAPI.SelectionSet {
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

              /// Customer.Orders.Edge.Node.LineItems
              ///
              /// Parent Type: `OrderLineItemConnection`
              public struct LineItems: ShopifyAPI.SelectionSet {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.OrderLineItemConnection }
                public static var __selections: [Apollo.Selection] { [
                  .field("__typename", String.self),
                  .field("edges", [Edge].self),
                ] }

                /// A list of edges.
                public var edges: [Edge] { __data["edges"] }

                /// Customer.Orders.Edge.Node.LineItems.Edge
                ///
                /// Parent Type: `OrderLineItemEdge`
                public struct Edge: ShopifyAPI.SelectionSet {
                  public let __data: DataDict
                  public init(_dataDict: DataDict) { __data = _dataDict }

                  public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.OrderLineItemEdge }
                  public static var __selections: [Apollo.Selection] { [
                    .field("__typename", String.self),
                    .field("node", Node.self),
                  ] }

                  /// The item at the end of OrderLineItemEdge.
                  public var node: Node { __data["node"] }

                  /// Customer.Orders.Edge.Node.LineItems.Edge.Node
                  ///
                  /// Parent Type: `OrderLineItem`
                  public struct Node: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.OrderLineItem }
                    public static var __selections: [Apollo.Selection] { [
                      .field("__typename", String.self),
                      .field("title", String.self),
                      .field("currentQuantity", Int.self),
                      .field("originalTotalPrice", OriginalTotalPrice.self),
                      .field("variant", Variant?.self),
                    ] }

                    /// The title of the product combined with title of the variant.
                    public var title: String { __data["title"] }
                    /// The number of entries associated to the line item minus the items that have been removed.
                    public var currentQuantity: Int { __data["currentQuantity"] }
                    /// The total price of the line item, not including any discounts. The total price is calculated using the original unit price multiplied by the quantity, and it is displayed in the presentment currency.
                    public var originalTotalPrice: OriginalTotalPrice { __data["originalTotalPrice"] }
                    /// The product variant object associated to the line item.
                    public var variant: Variant? { __data["variant"] }

                    /// Customer.Orders.Edge.Node.LineItems.Edge.Node.OriginalTotalPrice
                    ///
                    /// Parent Type: `MoneyV2`
                    public struct OriginalTotalPrice: ShopifyAPI.SelectionSet {
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

                    /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant
                    ///
                    /// Parent Type: `ProductVariant`
                    public struct Variant: ShopifyAPI.SelectionSet {
                      public let __data: DataDict
                      public init(_dataDict: DataDict) { __data = _dataDict }

                      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
                      public static var __selections: [Apollo.Selection] { [
                        .field("__typename", String.self),
                        .field("product", Product.self),
                        .fragment(ProductVariantInfo.self),
                      ] }

                      /// The product object that the product variant belongs to.
                      public var product: Product { __data["product"] }
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

                      /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product
                      ///
                      /// Parent Type: `Product`
                      public struct Product: ShopifyAPI.SelectionSet {
                        public let __data: DataDict
                        public init(_dataDict: DataDict) { __data = _dataDict }

                        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
                        public static var __selections: [Apollo.Selection] { [
                          .field("__typename", String.self),
                          .fragment(ProductInfo.self),
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
                        /// The product’s vendor name.
                        public var vendor: String { __data["vendor"] }
                        /// The featured image for the product.
                        ///
                        /// This field is functionally equivalent to `images(first: 1)`.
                        ///
                        public var featuredImage: FeaturedImage? { __data["featuredImage"] }
                        /// The price range.
                        public var priceRange: PriceRange { __data["priceRange"] }
                        /// List of the product’s variants.
                        public var variants: ProductInfo.Variants { __data["variants"] }

                        public struct Fragments: FragmentContainer {
                          public let __data: DataDict
                          public init(_dataDict: DataDict) { __data = _dataDict }

                          public var productInfo: ProductInfo { _toFragment() }
                        }

                        /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.FeaturedImage
                        ///
                        /// Parent Type: `Image`
                        public struct FeaturedImage: ShopifyAPI.SelectionSet {
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

                        /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange
                        ///
                        /// Parent Type: `ProductPriceRange`
                        public struct PriceRange: ShopifyAPI.SelectionSet {
                          public let __data: DataDict
                          public init(_dataDict: DataDict) { __data = _dataDict }

                          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }

                          /// The highest variant's price.
                          public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
                          /// The lowest variant's price.
                          public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

                          public struct Fragments: FragmentContainer {
                            public let __data: DataDict
                            public init(_dataDict: DataDict) { __data = _dataDict }

                            public var priceRangeInfo: PriceRangeInfo { _toFragment() }
                          }

                          /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange.MaxVariantPrice
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

                          /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Product.PriceRange.MinVariantPrice
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
                      }
                      /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Image
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

                      /// Customer.Orders.Edge.Node.LineItems.Edge.Node.Variant.Price
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
        }
      }
    }
  }

}