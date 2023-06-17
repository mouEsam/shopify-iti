// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class UpdateCartLinesMutation: GraphQLMutation {
    public static let operationName: String = "updateCartLines"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation updateCartLines($cartId: ID!, $lines: [CartLineUpdateInput!]!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          cartLinesUpdate(cartId: $cartId, lines: $lines) {
            __typename
            cart {
              __typename
              id
              lines(first: 10) {
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
                        amount
                      }
                      totalAmount {
                        __typename
                        amount
                      }
                    }
                    merchandise {
                      __typename
                      ...productVariantInfo
                    }
                  }
                }
              }
              attributes {
                __typename
                key
                value
              }
              cost {
                __typename
                totalAmount {
                  __typename
                  amount
                  currencyCode
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
          }
        }
        """#,
        fragments: [ProductVariantInfo.self, ImageInfo.self, MoneyInfo.self]
      ))

    public var cartId: ID
    public var lines: [CartLineUpdateInput]
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      cartId: ID,
      lines: [CartLineUpdateInput],
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.cartId = cartId
      self.lines = lines
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "cartId": cartId,
      "lines": lines,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("cartLinesUpdate", CartLinesUpdate?.self, arguments: [
          "cartId": .variable("cartId"),
          "lines": .variable("lines")
        ]),
      ] }

      /// Updates one or more merchandise lines on a cart.
      public var cartLinesUpdate: CartLinesUpdate? { __data["cartLinesUpdate"] }

      /// CartLinesUpdate
      ///
      /// Parent Type: `CartLinesUpdatePayload`
      public struct CartLinesUpdate: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartLinesUpdatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("cart", Cart?.self),
        ] }

        /// The updated cart.
        public var cart: Cart? { __data["cart"] }

        /// CartLinesUpdate.Cart
        ///
        /// Parent Type: `Cart`
        public struct Cart: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Cart }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAPI.ID.self),
            .field("lines", Lines.self, arguments: ["first": 10]),
            .field("attributes", [Attribute].self),
            .field("cost", Cost.self),
            .field("buyerIdentity", BuyerIdentity.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// A list of lines containing information about the items the customer intends to purchase.
          public var lines: Lines { __data["lines"] }
          /// The attributes associated with the cart. Attributes are represented as key-value pairs.
          public var attributes: [Attribute] { __data["attributes"] }
          /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
          public var cost: Cost { __data["cost"] }
          /// Information about the buyer that is interacting with the cart.
          public var buyerIdentity: BuyerIdentity { __data["buyerIdentity"] }

          /// CartLinesUpdate.Cart.Lines
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

            /// CartLinesUpdate.Cart.Lines.Edge
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

              /// CartLinesUpdate.Cart.Lines.Edge.Node
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

                /// CartLinesUpdate.Cart.Lines.Edge.Node.Cost
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

                  /// CartLinesUpdate.Cart.Lines.Edge.Node.Cost.AmountPerQuantity
                  ///
                  /// Parent Type: `MoneyV2`
                  public struct AmountPerQuantity: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
                    public static var __selections: [Apollo.Selection] { [
                      .field("__typename", String.self),
                      .field("amount", ShopifyAPI.Decimal.self),
                    ] }

                    /// Decimal money amount.
                    public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  }

                  /// CartLinesUpdate.Cart.Lines.Edge.Node.Cost.TotalAmount
                  ///
                  /// Parent Type: `MoneyV2`
                  public struct TotalAmount: ShopifyAPI.SelectionSet {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
                    public static var __selections: [Apollo.Selection] { [
                      .field("__typename", String.self),
                      .field("amount", ShopifyAPI.Decimal.self),
                    ] }

                    /// Decimal money amount.
                    public var amount: ShopifyAPI.Decimal { __data["amount"] }
                  }
                }

                /// CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise
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

                  /// CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                  ///
                  /// Parent Type: `ProductVariant`
                  public struct AsProductVariant: ShopifyAPI.InlineFragment {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public typealias RootEntityType = UpdateCartLinesMutation.Data.CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise
                    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductVariant }
                    public static var __selections: [Apollo.Selection] { [
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

                    /// CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image
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

                    /// CartLinesUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price
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

          /// CartLinesUpdate.Cart.Attribute
          ///
          /// Parent Type: `Attribute`
          public struct Attribute: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Attribute }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("key", String.self),
              .field("value", String?.self),
            ] }

            /// Key or name of the attribute.
            public var key: String { __data["key"] }
            /// Value of the attribute.
            public var value: String? { __data["value"] }
          }

          /// CartLinesUpdate.Cart.Cost
          ///
          /// Parent Type: `CartCost`
          public struct Cost: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartCost }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("totalAmount", TotalAmount.self),
            ] }

            /// The total amount for the customer to pay.
            public var totalAmount: TotalAmount { __data["totalAmount"] }

            /// CartLinesUpdate.Cart.Cost.TotalAmount
            ///
            /// Parent Type: `MoneyV2`
            public struct TotalAmount: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("amount", ShopifyAPI.Decimal.self),
                .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
              ] }

              /// Decimal money amount.
              public var amount: ShopifyAPI.Decimal { __data["amount"] }
              /// Currency of the money.
              public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
            }
          }

          /// CartLinesUpdate.Cart.BuyerIdentity
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

            /// CartLinesUpdate.Cart.BuyerIdentity.Customer
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
    }
  }

}