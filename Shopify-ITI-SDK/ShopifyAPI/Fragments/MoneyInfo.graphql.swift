// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct MoneyInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment moneyInfo on MoneyV2 {
        __typename
        amount
        currencyCode
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("amount", ShopifyAPI.Decimal.self),
      .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
    ] }

    /// Decimal money amount.
    public var amount: ShopifyAPI.Decimal { __data["amount"] }
    /// Currency of the money.
    public var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
  }

}