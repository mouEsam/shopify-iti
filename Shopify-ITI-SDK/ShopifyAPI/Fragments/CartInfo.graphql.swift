// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct CartInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment cartInfo on Cart {
        __typename
        id
        lines(first: 50) {
          __typename
          edges {
            __typename
            node {
              __typename
              id
              quantity
              cost {
                __typename
                amountPerQuantity {
                  __typename
                  ...moneyInfo
                }
                totalAmount {
                  __typename
                  ...moneyInfo
                }
              }
              merchandise {
                __typename
                ... on ProductVariant {
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
        cost {
          __typename
          totalAmount {
            __typename
            ...moneyInfo
          }
          subtotalAmount {
            __typename
            ...moneyInfo
          }
          totalTaxAmount {
            __typename
            ...moneyInfo
          }
        }
        buyerIdentity {
          __typename
          email
          phone
          customer {
            __typename
            id
          }
          countryCode
        }
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Cart }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("id", ShopifyAPI.ID.self),
      .field("lines", Lines.self, arguments: ["first": 50]),
      .field("cost", Cost.self),
      .field("buyerIdentity", BuyerIdentity.self),
    ] }

    /// A globally-unique ID.
    public var id: ShopifyAPI.ID { __data["id"] }
    /// A list of lines containing information about the items the customer intends to purchase.
    public var lines: Lines { __data["lines"] }
    /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
    public var cost: Cost { __data["cost"] }
    /// Information about the buyer that is interacting with the cart.
    public var buyerIdentity: BuyerIdentity { __data["buyerIdentity"] }

    /// Lines
    ///
    /// Parent Type: `BaseCartLineConnection`
    public struct Lines: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.BaseCartLineConnection }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge].self),
      ] }

      /// A list of edges.
      public var edges: [Edge] { __data["edges"] }

      /// Lines.Edge
      ///
      /// Parent Type: `BaseCartLineEdge`
      public struct Edge: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.BaseCartLineEdge }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
        ] }

        /// The item at the end of BaseCartLineEdge.
        public var node: Node { __data["node"] }

        /// Lines.Edge.Node
        ///
        /// Parent Type: `BaseCartLine`
        public struct Node: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Interfaces.BaseCartLine }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAPI.ID.self),
            .field("quantity", Int.self),
            .field("cost", Cost.self),
            .field("merchandise", Merchandise.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// The quantity of the merchandise that the customer intends to purchase.
          public var quantity: Int { __data["quantity"] }
          /// The cost of the merchandise that the buyer will pay for at checkout. The costs are subject to change and changes will be reflected at checkout.
          public var cost: Cost { __data["cost"] }
          /// The merchandise that the buyer intends to purchase.
          public var merchandise: Merchandise { __data["merchandise"] }

          /// Lines.Edge.Node.Cost
          ///
          /// Parent Type: `CartLineCost`
          public struct Cost: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartLineCost }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("amountPerQuantity", AmountPerQuantity.self),
              .field("totalAmount", TotalAmount.self),
            ] }

            /// The amount of the merchandise line.
            public var amountPerQuantity: AmountPerQuantity { __data["amountPerQuantity"] }
            /// The total cost of the merchandise line.
            public var totalAmount: TotalAmount { __data["totalAmount"] }

            /// Lines.Edge.Node.Cost.AmountPerQuantity
            ///
            /// Parent Type: `MoneyV2`
            public struct AmountPerQuantity: ShopifyAPI.SelectionSet {
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

            /// Lines.Edge.Node.Cost.TotalAmount
            ///
            /// Parent Type: `MoneyV2`
            public struct TotalAmount: ShopifyAPI.SelectionSet {
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
          }

          /// Lines.Edge.Node.Merchandise
          ///
          /// Parent Type: `Merchandise`
          public struct Merchandise: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Unions.Merchandise }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsProductVariant.self),
            ] }

            public var asProductVariant: AsProductVariant? { _asInlineFragment() }

            /// Lines.Edge.Node.Merchandise.AsProductVariant
            ///
            /// Parent Type: `ProductVariant`
            public struct AsProductVariant: ShopifyAPI.InlineFragment {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public typealias RootEntityType = CartInfo.Lines.Edge.Node.Merchandise
              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
              public static var __selections: [Apollo.Selection] { [
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

              /// Lines.Edge.Node.Merchandise.AsProductVariant.Product
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

                /// Lines.Edge.Node.Merchandise.AsProductVariant.Product.FeaturedImage
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

                /// Lines.Edge.Node.Merchandise.AsProductVariant.Product.PriceRange
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

                  /// Lines.Edge.Node.Merchandise.AsProductVariant.Product.PriceRange.MaxVariantPrice
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

                  /// Lines.Edge.Node.Merchandise.AsProductVariant.Product.PriceRange.MinVariantPrice
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
              /// Lines.Edge.Node.Merchandise.AsProductVariant.Image
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

              /// Lines.Edge.Node.Merchandise.AsProductVariant.Price
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

    /// Cost
    ///
    /// Parent Type: `CartCost`
    public struct Cost: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartCost }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("totalAmount", TotalAmount.self),
        .field("subtotalAmount", SubtotalAmount.self),
        .field("totalTaxAmount", TotalTaxAmount?.self),
      ] }

      /// The total amount for the customer to pay.
      public var totalAmount: TotalAmount { __data["totalAmount"] }
      /// The amount, before taxes and cart-level discounts, for the customer to pay.
      public var subtotalAmount: SubtotalAmount { __data["subtotalAmount"] }
      /// The tax amount for the customer to pay at checkout.
      public var totalTaxAmount: TotalTaxAmount? { __data["totalTaxAmount"] }

      /// Cost.TotalAmount
      ///
      /// Parent Type: `MoneyV2`
      public struct TotalAmount: ShopifyAPI.SelectionSet {
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

      /// Cost.SubtotalAmount
      ///
      /// Parent Type: `MoneyV2`
      public struct SubtotalAmount: ShopifyAPI.SelectionSet {
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

      /// Cost.TotalTaxAmount
      ///
      /// Parent Type: `MoneyV2`
      public struct TotalTaxAmount: ShopifyAPI.SelectionSet {
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
    }

    /// BuyerIdentity
    ///
    /// Parent Type: `CartBuyerIdentity`
    public struct BuyerIdentity: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartBuyerIdentity }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .field("email", String?.self),
        .field("phone", String?.self),
        .field("customer", Customer?.self),
        .field("countryCode", GraphQLEnum<ShopifyAPI.CountryCode>?.self),
      ] }

      /// The email address of the buyer that is interacting with the cart.
      public var email: String? { __data["email"] }
      /// The phone number of the buyer that is interacting with the cart.
      public var phone: String? { __data["phone"] }
      /// The customer account associated with the cart.
      public var customer: Customer? { __data["customer"] }
      /// The country where the buyer is located.
      public var countryCode: GraphQLEnum<ShopifyAPI.CountryCode>? { __data["countryCode"] }

      /// BuyerIdentity.Customer
      ///
      /// Parent Type: `Customer`
      public struct Customer: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Customer }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
        ] }

        /// A unique ID for the customer.
        public var id: ShopifyAPI.ID { __data["id"] }
      }
    }
  }

}