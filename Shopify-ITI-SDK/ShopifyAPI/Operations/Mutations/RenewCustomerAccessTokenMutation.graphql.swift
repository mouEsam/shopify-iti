// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class RenewCustomerAccessTokenMutation: GraphQLMutation {
    public static let operationName: String = "renewCustomerAccessToken"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation renewCustomerAccessToken($customerAccessToken: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customerAccessTokenRenew(customerAccessToken: $customerAccessToken) {
            __typename
            customerAccessToken {
              __typename
              accessToken
              expiresAt
            }
            userErrors {
              __typename
              field
              message
            }
          }
        }
        """#
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

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("customerAccessTokenRenew", CustomerAccessTokenRenew?.self, arguments: ["customerAccessToken": .variable("customerAccessToken")]),
      ] }

      /// Renews a customer access token.
      ///
      /// Access token renewal must happen *before* a token expires.
      /// If a token has already expired, a new one should be created instead via `customerAccessTokenCreate`.
      ///
      public var customerAccessTokenRenew: CustomerAccessTokenRenew? { __data["customerAccessTokenRenew"] }

      /// CustomerAccessTokenRenew
      ///
      /// Parent Type: `CustomerAccessTokenRenewPayload`
      public struct CustomerAccessTokenRenew: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerAccessTokenRenewPayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("customerAccessToken", CustomerAccessToken?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The renewed customer access token object.
        public var customerAccessToken: CustomerAccessToken? { __data["customerAccessToken"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// CustomerAccessTokenRenew.CustomerAccessToken
        ///
        /// Parent Type: `CustomerAccessToken`
        public struct CustomerAccessToken: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerAccessToken }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("accessToken", String.self),
            .field("expiresAt", ShopifyAPI.DateTime.self),
          ] }

          /// The customer’s access token.
          public var accessToken: String { __data["accessToken"] }
          /// The date and time when the customer access token expires.
          public var expiresAt: ShopifyAPI.DateTime { __data["expiresAt"] }
        }

        /// CustomerAccessTokenRenew.UserError
        ///
        /// Parent Type: `UserError`
        public struct UserError: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.UserError }
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