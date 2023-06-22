// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct MoneyInfo: ShopifyAdminAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment moneyInfo on MoneyV2 {
        __typename
        amount100: amount
        currencyCode
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("amount", alias: "amount100", ShopifyAdminAPI.Decimal.self),
      .field("currencyCode", GraphQLEnum<ShopifyAdminAPI.CurrencyCode>.self),
    ] }

    /// Decimal money amount.
    public var amount100: ShopifyAdminAPI.Decimal { __data["amount100"] }
    /// Currency of the money.
    public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }
  }

}