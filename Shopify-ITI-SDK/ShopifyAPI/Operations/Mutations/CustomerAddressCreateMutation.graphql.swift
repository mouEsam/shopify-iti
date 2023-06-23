// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class CustomerAddressCreateMutation: GraphQLMutation {
    public static let operationName: String = "customerAddressCreate"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        mutation customerAddressCreate($customerAccessToken: String!, $address: MailingAddressInput!) {
          customerAddressCreate(
            customerAccessToken: $customerAccessToken
            address: $address
          ) {
            __typename
            customerUserErrors {
              __typename
              code
              field
              message
            }
            customerAddress {
              __typename
              address1
              id
            }
          }
        }
        """#
      ))

    public var customerAccessToken: String
    public var address: MailingAddressInput

    public init(
      customerAccessToken: String,
      address: MailingAddressInput
    ) {
      self.customerAccessToken = customerAccessToken
      self.address = address
    }

    public var __variables: Variables? { [
      "customerAccessToken": customerAccessToken,
      "address": address
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Mutation }
      public static var __selections: [Apollo.Selection] { [
        .field("customerAddressCreate", CustomerAddressCreate?.self, arguments: [
          "customerAccessToken": .variable("customerAccessToken"),
          "address": .variable("address")
        ]),
      ] }

      /// Creates a new address for a customer.
      public var customerAddressCreate: CustomerAddressCreate? { __data["customerAddressCreate"] }

      /// CustomerAddressCreate
      ///
      /// Parent Type: `CustomerAddressCreatePayload`
      public struct CustomerAddressCreate: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.CustomerAddressCreatePayload }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("customerUserErrors", [CustomerUserError].self),
          .field("customerAddress", CustomerAddress?.self),
        ] }

        /// The list of errors that occurred from executing the mutation.
        public var customerUserErrors: [CustomerUserError] { __data["customerUserErrors"] }
        /// The new customer address object.
        public var customerAddress: CustomerAddress? { __data["customerAddress"] }

        /// CustomerAddressCreate.CustomerUserError
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

        /// CustomerAddressCreate.CustomerAddress
        ///
        /// Parent Type: `MailingAddress`
        public struct CustomerAddress: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MailingAddress }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("address1", String?.self),
            .field("id", ShopifyAPI.ID.self),
          ] }

          /// The first line of the address. Typically the street address or PO Box number.
          public var address1: String? { __data["address1"] }
          /// A globally-unique ID.
          public var id: ShopifyAPI.ID { __data["id"] }
        }
      }
    }
  }

}