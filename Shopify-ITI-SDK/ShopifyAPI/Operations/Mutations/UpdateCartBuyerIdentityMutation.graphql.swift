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
              ...cartInfo
            }
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#,
        fragments: [CartInfo.self, MoneyInfo.self, ProductVariantInfo.self, ImageInfo.self]
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