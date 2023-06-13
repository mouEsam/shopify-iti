// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields used to create a line item for a draft order.
  struct DraftOrderLineItemInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      appliedDiscount: GraphQLNullable<DraftOrderAppliedDiscountInput> = nil,
      customAttributes: GraphQLNullable<[AttributeInput]> = nil,
      originalUnitPrice: GraphQLNullable<Money> = nil,
      quantity: Int,
      requiresShipping: GraphQLNullable<Bool> = nil,
      sku: GraphQLNullable<String> = nil,
      taxable: GraphQLNullable<Bool> = nil,
      title: GraphQLNullable<String> = nil,
      variantId: GraphQLNullable<ID> = nil,
      weight: GraphQLNullable<WeightInput> = nil
    ) {
      __data = InputDict([
        "appliedDiscount": appliedDiscount,
        "customAttributes": customAttributes,
        "originalUnitPrice": originalUnitPrice,
        "quantity": quantity,
        "requiresShipping": requiresShipping,
        "sku": sku,
        "taxable": taxable,
        "title": title,
        "variantId": variantId,
        "weight": weight
      ])
    }

    /// Discount which will be applied to the line item.
    ///
    public var appliedDiscount: GraphQLNullable<DraftOrderAppliedDiscountInput> {
      get { __data["appliedDiscount"] }
      set { __data["appliedDiscount"] = newValue }
    }

    /// Represents a generic custom attribute using a key value pair.
    ///
    public var customAttributes: GraphQLNullable<[AttributeInput]> {
      get { __data["customAttributes"] }
      set { __data["customAttributes"] = newValue }
    }

    /// The price without any discounts applied. This value is ignored when `variantId` is provided.
    public var originalUnitPrice: GraphQLNullable<Money> {
      get { __data["originalUnitPrice"] }
      set { __data["originalUnitPrice"] = newValue }
    }

    /// The number of products that were purchased.
    ///
    public var quantity: Int {
      get { __data["quantity"] }
      set { __data["quantity"] = newValue }
    }

    /// Whether physical shipping is required. This value is ignored when `variantId` is provided.
    ///
    public var requiresShipping: GraphQLNullable<Bool> {
      get { __data["requiresShipping"] }
      set { __data["requiresShipping"] = newValue }
    }

    /// The SKU number of the item. This value is ignored when `variantId` is provided.
    public var sku: GraphQLNullable<String> {
      get { __data["sku"] }
      set { __data["sku"] = newValue }
    }

    /// Whether the item is taxable. This value is ignored when `variantId` is provided.
    public var taxable: GraphQLNullable<Bool> {
      get { __data["taxable"] }
      set { __data["taxable"] = newValue }
    }

    /// Title of the item. Ignored when `variantId` is provided.
    public var title: GraphQLNullable<String> {
      get { __data["title"] }
      set { __data["title"] = newValue }
    }

    /// The ID of the product variant corresponding to the line item.
    /// Null if custom line item. Required if product variant line item.
    ///
    public var variantId: GraphQLNullable<ID> {
      get { __data["variantId"] }
      set { __data["variantId"] = newValue }
    }

    /// Specifies the weight unit and value inputs.
    /// This value is ignored when `variantId` is provided.
    ///
    public var weight: GraphQLNullable<WeightInput> {
      get { __data["weight"] }
      set { __data["weight"] = newValue }
    }
  }

}