// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields for the context data that determines the pricing of a variant.
  struct ContextualPricingContext: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      country: GraphQLNullable<GraphQLEnum<CountryCode>> = nil,
      companyLocationId: GraphQLNullable<ID> = nil
    ) {
      __data = InputDict([
        "country": country,
        "companyLocationId": companyLocationId
      ])
    }

    /// The country code used to fetch country-specific prices.
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>> {
      get { __data["country"] }
      set { __data["country"] = newValue }
    }

    /// The CompanyLocation ID used to fetch company location specific prices.
    ///
    public var companyLocationId: GraphQLNullable<ID> {
      get { __data["companyLocationId"] }
      set { __data["companyLocationId"] = newValue }
    }
  }

}