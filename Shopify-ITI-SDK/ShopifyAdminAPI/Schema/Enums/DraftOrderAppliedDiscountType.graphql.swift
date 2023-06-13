// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The valid discount types that can be applied to a draft order.
  enum DraftOrderAppliedDiscountType: String, EnumType {
    /// A fixed amount in the store's currency.
    case fixedAmount = "FIXED_AMOUNT"
    /// A percentage of the order subtotal.
    case percentage = "PERCENTAGE"
  }

}