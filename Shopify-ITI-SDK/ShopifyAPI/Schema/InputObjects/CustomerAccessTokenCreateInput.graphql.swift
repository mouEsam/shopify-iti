// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI {
  /// The input fields required to create a customer access token.
  struct CustomerAccessTokenCreateInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      email: String,
      password: String
    ) {
      __data = InputDict([
        "email": email,
        "password": password
      ])
    }

    /// The email associated to the customer.
    public var email: String {
      get { __data["email"] }
      set { __data["email"] = newValue }
    }

    /// The login password to be used by the customer.
    public var password: String {
      get { __data["password"] }
      set { __data["password"] = newValue }
    }
  }

}