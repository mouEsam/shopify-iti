// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields for specifying the shipping details for the order.
  struct ShippingLineInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      price: GraphQLNullable<Money> = nil,
      shippingRateHandle: GraphQLNullable<String> = nil,
      title: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "price": price,
        "shippingRateHandle": shippingRateHandle,
        "title": title
      ])
    }

    /// Price of the shipping rate.
    public var price: GraphQLNullable<Money> {
      get { __data["price"] }
      set { __data["price"] = newValue }
    }

    /// A unique identifier for the shipping rate.
    public var shippingRateHandle: GraphQLNullable<String> {
      get { __data["shippingRateHandle"] }
      set { __data["shippingRateHandle"] = newValue }
    }

    /// Title of the shipping rate.
    public var title: GraphQLNullable<String> {
      get { __data["title"] }
      set { __data["title"] = newValue }
    }
  }

}