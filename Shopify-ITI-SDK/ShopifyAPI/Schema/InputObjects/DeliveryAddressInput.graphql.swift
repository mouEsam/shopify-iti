// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI {
  /// The input fields for delivery address preferences.
  ///
  struct DeliveryAddressInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      deliveryAddress: GraphQLNullable<MailingAddressInput> = nil,
      customerAddressId: GraphQLNullable<ID> = nil
    ) {
      __data = InputDict([
        "deliveryAddress": deliveryAddress,
        "customerAddressId": customerAddressId
      ])
    }

    /// A delivery address preference of a buyer that is interacting with the cart.
    public var deliveryAddress: GraphQLNullable<MailingAddressInput> {
      get { __data["deliveryAddress"] }
      set { __data["deliveryAddress"] = newValue }
    }

    /// The ID of a customer address that is associated with the buyer that is interacting with the cart.
    ///
    public var customerAddressId: GraphQLNullable<ID> {
      get { __data["customerAddressId"] }
      set { __data["customerAddressId"] = newValue }
    }
  }

}