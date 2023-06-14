// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class RemoveCartLinesMutation: GraphQLMutation {
    public static let operationName: String = "removeCartLines"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation removeCartLines($cartId: ID!, $lineIds: [ID!]!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          cartLinesRemove(cartId: $cartId, lineIds: $lineIds) {
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
            }
          }
        }
        """#,
        fragments: [ProductVariantInfo.self, ImageInfo.self, MoneyInfo.self]
      ))

    public var cartId: ID
    public var lineIds: [ID]
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      cartId: ID,
      lineIds: [ID],
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.cartId = cartId
      self.lineIds = lineIds
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "cartId": cartId,
      "lineIds": lineIds,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("cartLinesRemove", CartLinesRemove?.self, arguments: [
          "cartId": .variable("cartId"),
          "lineIds": .variable("lineIds")
        ]),
      ] }

      /// Removes one or more merchandise lines from the cart.
      public var cartLinesRemove: CartLinesRemove? { __data["cartLinesRemove"] }

      /// CartLinesRemove
      ///
      /// Parent Type: `CartLinesRemovePayload`
      public struct CartLinesRemove: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartLinesRemovePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("cart", Cart?.self),
        ] }

        /// The updated cart.
        public var cart: Cart? { __data["cart"] }

        /// CartLinesRemove.Cart
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
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// A list of lines containing information about the items the customer intends to purchase.
          public var lines: Lines { __data["lines"] }
          /// The attributes associated with the cart. Attributes are represented as key-value pairs.
          public var attributes: [Attribute] { __data["attributes"] }
          /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
          public var cost: Cost { __data["cost"] }

          /// CartLinesRemove.Cart.Lines
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

            /// CartLinesRemove.Cart.Lines.Edge
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

              /// CartLinesRemove.Cart.Lines.Edge.Node
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

                /// CartLinesRemove.Cart.Lines.Edge.Node.Cost
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

                  /// CartLinesRemove.Cart.Lines.Edge.Node.Cost.AmountPerQuantity
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

                  /// CartLinesRemove.Cart.Lines.Edge.Node.Cost.TotalAmount
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

                /// CartLinesRemove.Cart.Lines.Edge.Node.Merchandise
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

                  /// CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                  ///
                  /// Parent Type: `ProductVariant`
                  public struct AsProductVariant: ShopifyAPI.InlineFragment {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public typealias RootEntityType = RemoveCartLinesMutation.Data.CartLinesRemove.Cart.Lines.Edge.Node.Merchandise
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

                    /// CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image
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

                    /// CartLinesRemove.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price
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

          /// CartLinesRemove.Cart.Attribute
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

          /// CartLinesRemove.Cart.Cost
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

            /// CartLinesRemove.Cart.Cost.TotalAmount
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
        }
      }
    }
  }

}