// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  struct PriceRangeInfo: ShopifyAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString { """
      fragment priceRangeInfo on ProductPriceRange {
        __typename
        maxVariantPrice {
          __typename
          ...moneyInfo
        }
        minVariantPrice {
          __typename
          ...moneyInfo
        }
      }
      """ }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductPriceRange }
    static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("maxVariantPrice", MaxVariantPrice.self),
      .field("minVariantPrice", MinVariantPrice.self),
    ] }

    /// The highest variant's price.
    var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
    /// The lowest variant's price.
    var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

    /// MaxVariantPrice
    ///
    /// Parent Type: `MoneyV2`
    struct MaxVariantPrice: ShopifyAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
      static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(MoneyInfo.self),
      ] }

      /// Decimal money amount.
      var amount: ShopifyAPI.Decimal { __data["amount"] }
      /// Currency of the money.
      var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var moneyInfo: MoneyInfo { _toFragment() }
      }
    }

    /// MinVariantPrice
    ///
    /// Parent Type: `MoneyV2`
    struct MinVariantPrice: ShopifyAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.MoneyV2 }
      static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(MoneyInfo.self),
      ] }

      /// Decimal money amount.
      var amount: ShopifyAPI.Decimal { __data["amount"] }
      /// Currency of the money.
      var currencyCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["currencyCode"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var moneyInfo: MoneyInfo { _toFragment() }
      }
    }
  }

}