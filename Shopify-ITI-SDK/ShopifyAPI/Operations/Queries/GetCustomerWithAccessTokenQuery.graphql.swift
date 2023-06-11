// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetCustomerWithAccessTokenQuery: GraphQLQuery {
    public static let operationName: String = "getCustomerWithAccessToken"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getCustomerWithAccessToken($customerAccessToken: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customer(customerAccessToken: $customerAccessToken) {
            __typename
            id
            firstName
            lastName
            acceptsMarketing
            email
            phone
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

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("customer", Customer?.self, arguments: ["customerAccessToken": .variable("customerAccessToken")]),
      ] }

      /// The customer associated with the given access token. Tokens are obtained by using the
      /// [`customerAccessTokenCreate` mutation](https://shopify.dev/docs/api/storefront/latest/mutations/customerAccessTokenCreate).
      ///
      public var customer: Customer? { __data["customer"] }

      /// Customer
      ///
      /// Parent Type: `Customer`
      public struct Customer: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Customer }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("id", ShopifyAPI.ID.self),
          .field("firstName", String?.self),
          .field("lastName", String?.self),
          .field("acceptsMarketing", Bool.self),
          .field("email", String?.self),
          .field("phone", String?.self),
        ] }

        /// A unique ID for the customer.
        public var id: ShopifyAPI.ID { __data["id"] }
        /// The customer’s first name.
        public var firstName: String? { __data["firstName"] }
        /// The customer’s last name.
        public var lastName: String? { __data["lastName"] }
        /// Indicates whether the customer has consented to be sent marketing material via email.
        public var acceptsMarketing: Bool { __data["acceptsMarketing"] }
        /// The customer’s email address.
        public var email: String? { __data["email"] }
        /// The customer’s phone number.
        public var phone: String? { __data["phone"] }
      }
    }
  }

}