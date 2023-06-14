// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAPI {
  /// The input fields to create a cart.
  struct CartInput: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      attributes: GraphQLNullable<[AttributeInput]> = nil,
      lines: GraphQLNullable<[CartLineInput]> = nil,
      discountCodes: GraphQLNullable<[String]> = nil,
      note: GraphQLNullable<String> = nil,
      buyerIdentity: GraphQLNullable<CartBuyerIdentityInput> = nil,
      metafields: GraphQLNullable<[CartInputMetafieldInput]> = nil
    ) {
      __data = InputDict([
        "attributes": attributes,
        "lines": lines,
        "discountCodes": discountCodes,
        "note": note,
        "buyerIdentity": buyerIdentity,
        "metafields": metafields
      ])
    }

    /// An array of key-value pairs that contains additional information about the cart.
    public var attributes: GraphQLNullable<[AttributeInput]> {
      get { __data["attributes"] }
      set { __data["attributes"] = newValue }
    }

    /// A list of merchandise lines to add to the cart.
    public var lines: GraphQLNullable<[CartLineInput]> {
      get { __data["lines"] }
      set { __data["lines"] = newValue }
    }

    /// The case-insensitive discount codes that the customer added at checkout.
    ///
    public var discountCodes: GraphQLNullable<[String]> {
      get { __data["discountCodes"] }
      set { __data["discountCodes"] = newValue }
    }

    /// A note that is associated with the cart. For example, the note can be a personalized message to the buyer.
    public var note: GraphQLNullable<String> {
      get { __data["note"] }
      set { __data["note"] = newValue }
    }

    /// The customer associated with the cart. Used to determine [international pricing]
    /// (https://shopify.dev/custom-storefronts/internationalization/international-pricing).
    /// Buyer identity should match the customer's shipping address.
    ///
    public var buyerIdentity: GraphQLNullable<CartBuyerIdentityInput> {
      get { __data["buyerIdentity"] }
      set { __data["buyerIdentity"] = newValue }
    }

    /// The metafields to associate with this cart.
    public var metafields: GraphQLNullable<[CartInputMetafieldInput]> {
      get { __data["metafields"] }
      set { __data["metafields"] = newValue }
    }
  }

}