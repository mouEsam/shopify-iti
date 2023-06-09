// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  struct Test: ShopifyAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment test on MoneyV2 {
        __typename
        amount
        currencyCode
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
    static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("amount", ShopifyAPI.Decimal.self),
      .field("currencyCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
    ] }

    /// Decimal money amount.
    var amount: ShopifyAPI.Decimal { __data["amount"] }
    /// Currency of the money.
    var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }
  }

}