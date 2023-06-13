// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class CreateCustomerAccountMutation: GraphQLMutation {
    public static let operationName: String = "createCustomerAccount"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation createCustomerAccount($input: CustomerCreateInput!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          customerCreate(input: $input) {
            __typename
            customer {
              __typename
              id
              email
              displayName
              firstName
              lastName
              phone
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

    public var input: CustomerCreateInput
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      input: CustomerCreateInput,
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
        .field("customerCreate", CustomerCreate?.self, arguments: ["input": .variable("input")]),
      ] }

      /// Creates a new customer.
      public var customerCreate: CustomerCreate? { __data["customerCreate"] }

      /// CustomerCreate
      ///
      /// Parent Type: `CustomerCreatePayload`
      public struct CustomerCreate: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerCreatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("customer", Customer?.self),
          .field("customerUserErrors", [CustomerUserError].self),
        ] }

        /// The created customer object.
        public var customer: Customer? { __data["customer"] }
        /// The list of errors that occurred from executing the mutation.
        public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }

        /// CustomerCreate.Customer
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
            .field("displayName", String.self),
            .field("firstName", String?.self),
            .field("lastName", String?.self),
            .field("phone", String?.self),
          ] }

          /// A unique ID for the customer.
          public var id: ShopifyAPI.ID { __data["id"] }
          /// The customer’s email address.
          public var email: String? { __data["email"] }
          /// The customer’s name, email or phone number.
          public var displayName: String { __data["displayName"] }
          /// The customer’s first name.
          public var firstName: String? { __data["firstName"] }
          /// The customer’s last name.
          public var lastName: String? { __data["lastName"] }
          /// The customer’s phone number.
          public var phone: String? { __data["phone"] }
        }

        /// CustomerCreate.CustomerUserError
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