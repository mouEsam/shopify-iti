// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields for a purchasing entity. Can either be a customer or a purchasing company.
  struct PurchasingEntityInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      customerId: GraphQLNullable<ID> = nil,
      purchasingCompany: GraphQLNullable<PurchasingCompanyInput> = nil
    ) {
      __data = InputDict([
        "customerId": customerId,
        "purchasingCompany": purchasingCompany
      ])
    }

    /// Represents a customer. Null if there is a purchasing company.
    public var customerId: GraphQLNullable<ID> {
      get { __data["customerId"] }
      set { __data["customerId"] = newValue }
    }

    /// Represents a purchasing company. Null if there is a customer.
    public var purchasingCompany: GraphQLNullable<PurchasingCompanyInput> {
      get { __data["purchasingCompany"] }
      set { __data["purchasingCompany"] = newValue }
    }
  }

}