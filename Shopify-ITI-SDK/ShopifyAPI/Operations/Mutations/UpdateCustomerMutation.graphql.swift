// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class UpdateCustomerMutation: GraphQLMutation {
    public static let operationName: String = "updateCustomer"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation updateCustomer($customerAccessToken: String!, $customer: CustomerUpdateInput!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customerUpdate(customerAccessToken: $customerAccessToken, customer: $customer) {
            __typename
            customer {
              __typename
              id
              email
              firstName
              lastName
              phone
            }
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

    public var customerAccessToken: String
    public var customer: CustomerUpdateInput
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      customerAccessToken: String,
      customer: CustomerUpdateInput,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.customerAccessToken = customerAccessToken
      self.customer = customer
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "customerAccessToken": customerAccessToken,
      "customer": customer,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("customerUpdate", CustomerUpdate?.self, arguments: [
          "customerAccessToken": .variable("customerAccessToken"),
          "customer": .variable("customer")
        ]),
      ] }

      /// Updates an existing customer.
      public var customerUpdate: CustomerUpdate? { __data["customerUpdate"] }

      /// CustomerUpdate
      ///
      /// Parent Type: `CustomerUpdatePayload`
      public struct CustomerUpdate: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerUpdatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("customer", Customer?.self),
          .field("customerAccessToken", CustomerAccessToken?.self),
          .field("customerUserErrors", [CustomerUserError].self),
        ] }

        /// The updated customer object.
        public var customer: Customer? { __data["customer"] }
        /// The newly created customer access token. If the customer's password is updated, all previous access tokens
        /// (including the one used to perform this mutation) become invalid, and a new token is generated.
        ///
        public var customerAccessToken: CustomerAccessToken? { __data["customerAccessToken"] }
        /// The list of errors that occurred from executing the mutation.
        public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

        /// CustomerUpdate.Customer
        ///
        /// Parent Type: `Customer`
        public struct Customer: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Customer }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("id", ShopifyAPI.ID.self),
            .field("email", String?.self),
            .field("firstName", String?.self),
            .field("lastName", String?.self),
            .field("phone", String?.self),
          ] }

          /// A unique ID for the customer.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// The customer’s email address.
          public var email: String? { __data["email"] }
          /// The customer’s first name.
          public var firstName: String? { __data["firstName"] }
          /// The customer’s last name.
          public var lastName: String? { __data["lastName"] }
          /// The customer’s phone number.
          public var phone: String? { __data["phone"] }
        }

        /// CustomerUpdate.CustomerAccessToken
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

        /// CustomerUpdate.CustomerUserError
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