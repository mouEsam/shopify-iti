// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields used to create a payment schedule for payment terms.
  struct PaymentScheduleInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      issuedAt: GraphQLNullable<DateTime> = nil,
      dueAt: GraphQLNullable<DateTime> = nil
    ) {
      __data = InputDict([
        "issuedAt": issuedAt,
        "dueAt": dueAt
      ])
    }

    /// Specifies the date and time that the payment schedule was issued. This field must be provided for net type payment terms.
    public var issuedAt: GraphQLNullable<DateTime> {
      get { __data["issuedAt"] }
      set { __data["issuedAt"] = newValue }
    }

    /// Specifies the date and time when the payment schedule is due. This field must be provided for fixed type payment terms.
    public var dueAt: GraphQLNullable<DateTime> {
      get { __data["dueAt"] }
      set { __data["dueAt"] = newValue }
    }
  }

}