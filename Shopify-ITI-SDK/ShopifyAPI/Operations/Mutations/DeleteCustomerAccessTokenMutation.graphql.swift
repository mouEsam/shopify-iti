// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class DeleteCustomerAccessTokenMutation: GraphQLMutation {
    public static let operationName: String = "deleteCustomerAccessToken"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation deleteCustomerAccessToken($customerAccessToken: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customerAccessTokenDelete(customerAccessToken: $customerAccessToken) {
            __typename
            deletedAccessToken
            deletedCustomerAccessTokenId
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
        .field("customerAccessTokenDelete", CustomerAccessTokenDelete?.self, arguments: ["customerAccessToken": .variable("customerAccessToken")]),
      ] }

      /// Permanently destroys a customer access token.
      public var customerAccessTokenDelete: CustomerAccessTokenDelete? { __data["customerAccessTokenDelete"] }

      /// CustomerAccessTokenDelete
      ///
      /// Parent Type: `CustomerAccessTokenDeletePayload`
      public struct CustomerAccessTokenDelete: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerAccessTokenDeletePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("deletedAccessToken", String?.self),
          .field("deletedCustomerAccessTokenId", String?.self),
          .field("userErrors", [UserError].self),
        ] }

        /// The destroyed access token.
        public var deletedAccessToken: String? { __data["deletedAccessToken"] }
        /// ID of the destroyed customer access token.
        public var deletedCustomerAccessTokenId: String? { __data["deletedCustomerAccessTokenId"] }
        /// The list of errors that occurred from executing the mutation.
        public var userErrors: [UserError] { __data["userErrors"] }

        /// CustomerAccessTokenDelete.UserError
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