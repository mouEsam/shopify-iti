// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetCustomerAddressesQuery: GraphQLQuery {
    public static let operationName: String = "getCustomerAddresses"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getCustomerAddresses($customerAccessToken: String!) {
          customer(customerAccessToken: $customerAccessToken) {
            __typename
            addresses(first: 10) {
              __typename
              edges {
                __typename
                node {
                  __typename
                  address1
                }
              }
            }
          }
        }
        """#
      ))

    public var customerAccessToken: String

    public init(customerAccessToken: String) {
      self.customerAccessToken = customerAccessToken
    }

    public var __variables: Variables? { ["customerAccessToken": customerAccessToken] }

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
          .field("addresses", Addresses.self, arguments: ["first": 10]),
        ] }

        /// A list of addresses for the customer.
        public var addresses: Addresses { __data["addresses"] }

        /// Customer.Addresses
        ///
        /// Parent Type: `MailingAddressConnection`
        public struct Addresses: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MailingAddressConnection }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("edges", [Edge].self),
          ] }

          /// A list of edges.
          public var edges: [Edge] { __data["edges"] }

          /// Customer.Addresses.Edge
          ///
          /// Parent Type: `MailingAddressEdge`
          public struct Edge: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MailingAddressEdge }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("node", Node.self),
            ] }

            /// The item at the end of MailingAddressEdge.
            public var node: Node { __data["node"] }

            /// Customer.Addresses.Edge.Node
            ///
            /// Parent Type: `MailingAddress`
            public struct Node: ShopifyAPI.SelectionSet {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MailingAddress }
              public static var __selections: [Apollo.Selection] { [
                .field("__typename", String.self),
                .field("address1", String?.self),
              ] }

              /// The first line of the address. Typically the street address or PO Box number.
              public var address1: String? { __data["address1"] }
            }
          }
        }
      }
    }
  }

}