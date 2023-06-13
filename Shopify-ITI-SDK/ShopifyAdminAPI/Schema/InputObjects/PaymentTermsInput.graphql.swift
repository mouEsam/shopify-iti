// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields used to create a payment terms.
  struct PaymentTermsInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      paymentTermsTemplateId: GraphQLNullable<ID> = nil,
      paymentSchedules: GraphQLNullable<[PaymentScheduleInput]> = nil
    ) {
      __data = InputDict([
        "paymentTermsTemplateId": paymentTermsTemplateId,
        "paymentSchedules": paymentSchedules
      ])
    }

    /// Specifies the payment terms template ID used to generate payment terms.
    public var paymentTermsTemplateId: GraphQLNullable<ID> {
      get { __data["paymentTermsTemplateId"] }
      set { __data["paymentTermsTemplateId"] = newValue }
    }

    /// Specifies the payment schedules for the payment terms.
    public var paymentSchedules: GraphQLNullable<[PaymentScheduleInput]> {
      get { __data["paymentSchedules"] }
      set { __data["paymentSchedules"] = newValue }
    }
  }

}