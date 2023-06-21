// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class UpdateCartBuyerIdentityMutation: GraphQLMutation {
    public static let operationName: String = "updateCartBuyerIdentity"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation updateCartBuyerIdentity($buyerIdentity: CartBuyerIdentityInput!, $cartId: ID!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          cartBuyerIdentityUpdate(buyerIdentity: $buyerIdentity, cartId: $cartId) {
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
                        ...moneyInfo
                      }
                      totalAmount {
                        __typename
                        ...moneyInfo
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
                deliveryAddressPreferences {
                  __typename
                  ... on MailingAddress {
                    address1
                    city
                    country
                    firstName
                    lastName
                  }
                }
              }
            }
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#,
        fragments: [MoneyInfo.self, ProductVariantInfo.self, ImageInfo.self]
      ))

    public var buyerIdentity: CartBuyerIdentityInput
    public var cartId: ID
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      buyerIdentity: CartBuyerIdentityInput,
      cartId: ID,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.buyerIdentity = buyerIdentity
      self.cartId = cartId
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "buyerIdentity": buyerIdentity,
      "cartId": cartId,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("cartBuyerIdentityUpdate", CartBuyerIdentityUpdate?.self, arguments: [
          "buyerIdentity": .variable("buyerIdentity"),
          "cartId": .variable("cartId")
        ]),
      ] }

      /// Updates customer information associated with a cart.
      /// Buyer identity is used to determine
      /// [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing)
      /// and should match the customer's shipping address.
      ///
      public var cartBuyerIdentityUpdate: CartBuyerIdentityUpdate? { __data["cartBuyerIdentityUpdate"] }

      /// CartBuyerIdentityUpdate
      ///
      /// Parent Type: `CartBuyerIdentityUpdatePayload`
      public struct CartBuyerIdentityUpdate: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartBuyerIdentityUpdatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("cart", Cart?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The updated cart.
        public var cart: Cart? { __data["cart"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// CartBuyerIdentityUpdate.Cart
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

          /// CartBuyerIdentityUpdate.Cart.Lines
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

            /// CartBuyerIdentityUpdate.Cart.Lines.Edge
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

              /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node
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

                /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Cost
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

                  /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Cost.AmountPerQuantity
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

                  /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Cost.TotalAmount
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

                /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise
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

                  /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant
                  ///
                  /// Parent Type: `ProductVariant`
                  public struct AsProductVariant: ShopifyAPI.InlineFragment {
                    public let __data: DataDict
                    public init(_dataDict: DataDict) { __data = _dataDict }

                    public typealias RootEntityType = UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise
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

                    /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Image
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

                    /// CartBuyerIdentityUpdate.Cart.Lines.Edge.Node.Merchandise.AsProductVariant.Price
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

          /// CartBuyerIdentityUpdate.Cart.Attribute
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

          /// CartBuyerIdentityUpdate.Cart.Cost
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

            /// CartBuyerIdentityUpdate.Cart.Cost.TotalAmount
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

          /// CartBuyerIdentityUpdate.Cart.BuyerIdentity
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
              .field("deliveryAddressPreferences", [DeliveryAddressPreference].self),
            ] }

            /// The email address of the buyer that is interacting with the cart.
            public var email: String? { __data["email"] }
            /// The phone number of the buyer that is interacting with the cart.
            public var phone: String? { __data["phone"] }
            /// The customer account associated with the cart.
            public var customer: Customer? { __data["customer"] }
            /// An ordered set of delivery addresses tied to the buyer that is interacting with the cart.
            /// The rank of the preferences is determined by the order of the addresses in the array. Preferences
            /// can be used to populate relevant fields in the checkout flow.
            ///
            public var deliveryAddressPreferences: [DeliveryAddressPreference] { __data["deliveryAddressPreferences"] }

            /// CartBuyerIdentityUpdate.Cart.BuyerIdentity.Customer
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

            /// CartBuyerIdentityUpdate.Cart.BuyerIdentity.DeliveryAddressPreference
            ///
            /// Parent Type: `DeliveryAddress`
            public struct DeliveryAddressPreference: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Unions.DeliveryAddress }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .inlineFragment(AsMailingAddress.self),
              ] }

              public var asMailingAddress: AsMailingAddress? { _asInlineFragment() }

              /// CartBuyerIdentityUpdate.Cart.BuyerIdentity.DeliveryAddressPreference.AsMailingAddress
              ///
              /// Parent Type: `MailingAddress`
              public struct AsMailingAddress: ShopifyAPI.InlineFragment {
                public let __data: DataDict
                public init(_dataDict: DataDict) { __data = _dataDict }

                public typealias RootEntityType = UpdateCartBuyerIdentityMutation.Data.CartBuyerIdentityUpdate.Cart.BuyerIdentity.DeliveryAddressPreference
                public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MailingAddress }
                public static var __selections: [Apollo.Selection] { [
                  .field("address1", String?.self),
                  .field("city", String?.self),
                  .field("country", String?.self),
                  .field("firstName", String?.self),
                  .field("lastName", String?.self),
                ] }

                /// The first line of the address. Typically the street address or PO Box number.
                public var address1: String? { __data["address1"] }
                /// The name of the city, district, village, or town.
                ///
                public var city: String? { __data["city"] }
                /// The name of the country.
                ///
                public var country: String? { __data["country"] }
                /// The first name of the customer.
                public var firstName: String? { __data["firstName"] }
                /// The last name of the customer.
                public var lastName: String? { __data["lastName"] }
              }
            }
          }
        }

        /// CartBuyerIdentityUpdate.UserError
        ///
        /// Parent Type: `CartUserError`
        public struct UserError: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartUserError }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("field", [String]?.self),
            .field("message", String.self),
          ] }

          /// The path to the input field that caused the error.
          public var field: [String]? { __data["field"] }
          /// The error message.
          public var message: String { __data["message"] }
        }
      }
    }
  }

}