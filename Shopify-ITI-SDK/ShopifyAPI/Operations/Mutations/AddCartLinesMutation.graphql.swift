// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class AddCartLinesMutation: GraphQLMutation {
    public static let operationName: String = "addCartLines"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation addCartLines($cartId: ID!, $lines: [CartLineInput!]!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          cartLinesAdd(cartId: $cartId, lines: $lines) {
            __typename
            cart {
              __typename
              ...cartInfo
            }
          }
        }
        """#,
        fragments: [CartInfo.self, MoneyInfo.self, ProductVariantInfo.self, ImageInfo.self]
      ))

    public var cartId: ID
    public var lines: [CartLineInput]
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      cartId: ID,
      lines: [CartLineInput],
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
        .field("cartLinesAdd", CartLinesAdd?.self, arguments: [
          "cartId": .variable("cartId"),
          "lines": .variable("lines")
        ]),
      ] }

      /// Adds a merchandise line to the cart.
      public var cartLinesAdd: CartLinesAdd? { __data["cartLinesAdd"] }

      /// CartLinesAdd
      ///
      /// Parent Type: `CartLinesAddPayload`
      public struct CartLinesAdd: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CartLinesAddPayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("cart", Cart?.self),
        ] }

        /// The updated cart.
        public var cart: Cart? { __data["cart"] }

        /// CartLinesAdd.Cart
        ///
        /// Parent Type: `Cart`
        public struct Cart: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Cart }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .fragment(CartInfo.self),
          ] }

          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// A list of lines containing information about the items the customer intends to purchase.
          public var lines: CartInfo.Lines { __data["lines"] }
          /// The estimated costs that the buyer will pay at checkout. The costs are subject to change and changes will be reflected at checkout. The `cost` field uses the `buyerIdentity` field to determine [international pricing](https://shopify.dev/custom-storefronts/internationalization/international-pricing).
          public var cost: CartInfo.Cost { __data["cost"] }
          /// Information about the buyer that is interacting with the cart.
          public var buyerIdentity: CartInfo.BuyerIdentity { __data["buyerIdentity"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var cartInfo: CartInfo { _toFragment() }
          }
        }
      }
    }
  }

}