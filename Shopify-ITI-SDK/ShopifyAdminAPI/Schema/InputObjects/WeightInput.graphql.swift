// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields for the weight unit and value inputs.
  ///
  struct WeightInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      value: Double,
      unit: GraphQLEnum<WeightUnit>
    ) {
      __data = InputDict([
        "value": value,
        "unit": unit
      ])
    }

    /// The weight value using the unit system specified with `weight_unit`.
    public var value: Double {
      get { __data["value"] }
      set { __data["value"] = newValue }
    }

    /// Unit of measurement for `value`.
    public var unit: GraphQLEnum<WeightUnit> {
      get { __data["unit"] }
      set { __data["unit"] = newValue }
    }
  }

}