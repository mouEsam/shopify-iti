// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class CreateCustomerAccessTokenMutation: GraphQLMutation {
    public static let operationName: String = "createCustomerAccessToken"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation createCustomerAccessToken($input: CustomerAccessTokenCreateInput!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customerAccessTokenCreate(input: $input) {
            __typename
            customerAccessToken {
              __typename
              accessToken
              expiresAt
            }
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

    public var input: CustomerAccessTokenCreateInput
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      input: CustomerAccessTokenCreateInput,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.input = input
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "input": input,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("customerAccessTokenCreate", CustomerAccessTokenCreate?.self, arguments: ["input": .variable("input")]),
      ] }

      /// Creates a customer access token.
      /// The customer access token is required to modify the customer object in any way.
      ///
      public var customerAccessTokenCreate: CustomerAccessTokenCreate? { __data["customerAccessTokenCreate"] }

      /// CustomerAccessTokenCreate
      ///
      /// Parent Type: `CustomerAccessTokenCreatePayload`
      public struct CustomerAccessTokenCreate: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerAccessTokenCreatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("customerAccessToken", CustomerAccessToken?.self),
          .field("customerUserErrors", [CustomerUserError].self),
        ] }

        /// The newly created customer access token object.
        public var customerAccessToken: CustomerAccessToken? { __data["customerAccessToken"] }
        /// The list of errors that occurred from executing the mutation.
        public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

        /// CustomerAccessTokenCreate.CustomerAccessToken
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

        /// CustomerAccessTokenCreate.CustomerUserError
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