// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class RecoverCustomerAccountMutation: GraphQLMutation {
    public static let operationName: String = "recoverCustomerAccount"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation recoverCustomerAccount($email: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customerRecover(email: $email) {
            __typename
            customerUserErrors {
              __typename
              code
              field
              message
            }
          }
        }
        """#
      ))

    public var email: String
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      email: String,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.email = email
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "email": email,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("customerRecover", CustomerRecover?.self, arguments: ["email": .variable("email")]),
      ] }

      /// Sends a reset password email to the customer. The reset password
      /// email contains a reset password URL and token that you can pass to
      /// the [`customerResetByUrl`](https://shopify.dev/api/storefront/latest/mutations/customerResetByUrl) or
      /// [`customerReset`](https://shopify.dev/api/storefront/latest/mutations/customerReset) mutation to reset the
      /// customer password.
      ///
      /// This mutation is throttled by IP. With authenticated access,
      /// you can provide a [`Shopify-Storefront-Buyer-IP`](https://shopify.dev/api/usage/authentication#optional-ip-header) instead of the request IP.
      ///
      /// Make sure that the value provided to `Shopify-Storefront-Buyer-IP` is trusted. Unthrottled access to this
      /// mutation presents a security risk.
      ///
      public var customerRecover: CustomerRecover? { __data["customerRecover"] }

      /// CustomerRecover
      ///
      /// Parent Type: `CustomerRecoverPayload`
      public struct CustomerRecover: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerRecoverPayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("customerUserErrors", [CustomerUserError].self),
        ] }

        /// The list of errors that occurred from executing the mutation.
        public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

        /// CustomerRecover.CustomerUserError
        ///
        /// Parent Type: `CustomerUserError`
        public struct CustomerUserError: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerUserError }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("code", GraphQLEnum<ShopifyAPI.CustomerErrorCode>?.self),
            .field("field", [String]?.self),
            .field("message", String.self),
          ] }

          /// The error code.
          public var code: GraphQLEnum<ShopifyAPI.CustomerErrorCode>? { __data["code"] }
          /// The path to the input field that caused the error.
          public var field: [String]? { __data["field"] }
          /// The error message.
          public var message: String { __data["message"] }
        }
      }
    }
  }

}