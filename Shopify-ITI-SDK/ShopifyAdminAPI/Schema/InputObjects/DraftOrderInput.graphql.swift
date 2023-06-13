// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI {
  /// The input fields used to create or update a draft order.
  struct DraftOrderInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      appliedDiscount: GraphQLNullable<DraftOrderAppliedDiscountInput> = nil,
      billingAddress: GraphQLNullable<MailingAddressInput> = nil,
      customAttributes: GraphQLNullable<[AttributeInput]> = nil,
      email: GraphQLNullable<String> = nil,
      lineItems: GraphQLNullable<[DraftOrderLineItemInput]> = nil,
      metafields: GraphQLNullable<[MetafieldInput]> = nil,
      localizationExtensions: GraphQLNullable<[LocalizationExtensionInput]> = nil,
      note: GraphQLNullable<String> = nil,
      shippingAddress: GraphQLNullable<MailingAddressInput> = nil,
      shippingLine: GraphQLNullable<ShippingLineInput> = nil,
      tags: GraphQLNullable<[String]> = nil,
      taxExempt: GraphQLNullable<Bool> = nil,
      useCustomerDefaultAddress: GraphQLNullable<Bool> = nil,
      visibleToCustomer: GraphQLNullable<Bool> = nil,
      reserveInventoryUntil: GraphQLNullable<DateTime> = nil,
      presentmentCurrencyCode: GraphQLNullable<GraphQLEnum<CurrencyCode>> = nil,
      marketRegionCountryCode: GraphQLNullable<GraphQLEnum<CountryCode>> = nil,
      phone: GraphQLNullable<String> = nil,
      paymentTerms: GraphQLNullable<PaymentTermsInput> = nil,
      purchasingEntity: GraphQLNullable<PurchasingEntityInput> = nil,
      sourceName: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "appliedDiscount": appliedDiscount,
        "billingAddress": billingAddress,
        "customAttributes": customAttributes,
        "email": email,
        "lineItems": lineItems,
        "metafields": metafields,
        "localizationExtensions": localizationExtensions,
        "note": note,
        "shippingAddress": shippingAddress,
        "shippingLine": shippingLine,
        "tags": tags,
        "taxExempt": taxExempt,
        "useCustomerDefaultAddress": useCustomerDefaultAddress,
        "visibleToCustomer": visibleToCustomer,
        "reserveInventoryUntil": reserveInventoryUntil,
        "presentmentCurrencyCode": presentmentCurrencyCode,
        "marketRegionCountryCode": marketRegionCountryCode,
        "phone": phone,
        "paymentTerms": paymentTerms,
        "purchasingEntity": purchasingEntity,
        "sourceName": sourceName
      ])
    }

    /// The discount that will be applied to the draft order.
    /// A draft order line item can have one discount. A draft order can also have one order-level discount.
    ///
    public var appliedDiscount: GraphQLNullable<DraftOrderAppliedDiscountInput> {
      get { __data["appliedDiscount"] }
      set { __data["appliedDiscount"] = newValue }
    }

    /// The mailing address associated with the payment method.
    ///
    public var billingAddress: GraphQLNullable<MailingAddressInput> {
      get { __data["billingAddress"] }
      set { __data["billingAddress"] = newValue }
    }

    /// Extra information added to the customer.
    ///
    public var customAttributes: GraphQLNullable<[AttributeInput]> {
      get { __data["customAttributes"] }
      set { __data["customAttributes"] = newValue }
    }

    /// The customer's email address.
    ///
    public var email: GraphQLNullable<String> {
      get { __data["email"] }
      set { __data["email"] = newValue }
    }

    /// Product variant line item or custom line item associated to the draft order.
    /// Each draft order must include at least one line item.
    ///
    public var lineItems: GraphQLNullable<[DraftOrderLineItemInput]> {
      get { __data["lineItems"] }
      set { __data["lineItems"] = newValue }
    }

    /// Metafields attached to the draft order.
    ///
    public var metafields: GraphQLNullable<[MetafieldInput]> {
      get { __data["metafields"] }
      set { __data["metafields"] = newValue }
    }

    /// The localization extensions attached to the draft order. For example, Tax IDs.
    public var localizationExtensions: GraphQLNullable<[LocalizationExtensionInput]> {
      get { __data["localizationExtensions"] }
      set { __data["localizationExtensions"] = newValue }
    }

    /// The text of an optional note that a shop owner can attach to the draft order.
    ///
    public var note: GraphQLNullable<String> {
      get { __data["note"] }
      set { __data["note"] = newValue }
    }

    /// The mailing address to where the order will be shipped.
    ///
    public var shippingAddress: GraphQLNullable<MailingAddressInput> {
      get { __data["shippingAddress"] }
      set { __data["shippingAddress"] = newValue }
    }

    /// A shipping line object, which details the shipping method used.
    ///
    public var shippingLine: GraphQLNullable<ShippingLineInput> {
      get { __data["shippingLine"] }
      set { __data["shippingLine"] = newValue }
    }

    /// A comma separated list of tags that have been added to the draft order.
    ///
    public var tags: GraphQLNullable<[String]> {
      get { __data["tags"] }
      set { __data["tags"] = newValue }
    }

    /// Whether or not taxes are exempt for the draft order.
    /// If false, then Shopify will refer to the taxable field for each line item.
    /// If a customer is applied to the draft order, then Shopify will use the customer's tax exempt field instead.
    ///
    public var taxExempt: GraphQLNullable<Bool> {
      get { __data["taxExempt"] }
      set { __data["taxExempt"] = newValue }
    }

    /// Sent as part of a draft order object to load customer shipping information.
    ///
    public var useCustomerDefaultAddress: GraphQLNullable<Bool> {
      get { __data["useCustomerDefaultAddress"] }
      set { __data["useCustomerDefaultAddress"] = newValue }
    }

    /// Whether the draft order will be visible to the customer on the self-serve portal.
    public var visibleToCustomer: GraphQLNullable<Bool> {
      get { __data["visibleToCustomer"] }
      set { __data["visibleToCustomer"] = newValue }
    }

    /// Time after which inventory will automatically be restocked.
    public var reserveInventoryUntil: GraphQLNullable<DateTime> {
      get { __data["reserveInventoryUntil"] }
      set { __data["reserveInventoryUntil"] = newValue }
    }

    /// The payment currency of the customer for this draft order.
    public var presentmentCurrencyCode: GraphQLNullable<GraphQLEnum<CurrencyCode>> {
      get { __data["presentmentCurrencyCode"] }
      set { __data["presentmentCurrencyCode"] = newValue }
    }

    /// The selected market region country code for the draft order.
    public var marketRegionCountryCode: GraphQLNullable<GraphQLEnum<CountryCode>> {
      get { __data["marketRegionCountryCode"] }
      set { __data["marketRegionCountryCode"] = newValue }
    }

    /// The customer's phone number.
    public var phone: GraphQLNullable<String> {
      get { __data["phone"] }
      set { __data["phone"] = newValue }
    }

    /// The fields used to create payment terms.
    public var paymentTerms: GraphQLNullable<PaymentTermsInput> {
      get { __data["paymentTerms"] }
      set { __data["paymentTerms"] = newValue }
    }

    /// The purchasing entity for this draft order.
    public var purchasingEntity: GraphQLNullable<PurchasingEntityInput> {
      get { __data["purchasingEntity"] }
      set { __data["purchasingEntity"] = newValue }
    }

    /// The source of the checkout.
    ///           To use this field for sales attribution, you must register the channels that your app is managing.
    ///           You can register the channels that your app is managing by completing
    ///           [this Google Form](https://docs.google.com/forms/d/e/1FAIpQLScmVTZRQNjOJ7RD738mL1lGeFjqKVe_FM2tO9xsm21QEo5Ozg/viewform?usp=sf_link).
    ///           After you've submitted your request, you need to wait for your request to be processed by Shopify.
    ///           You can find a list of your channels in the Partner Dashboard, in your app's Marketplace extension.
    ///           You need to specify the handle as the `source_name` value in your request.
    ///           The handle is the channel that the order was placed from.
    public var sourceName: GraphQLNullable<String> {
      get { __data["sourceName"] }
      set { __data["sourceName"] = newValue }
    }
  }

}