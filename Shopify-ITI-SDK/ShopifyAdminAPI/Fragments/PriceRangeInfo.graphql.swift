// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAdminAPI {
  struct PriceRangeInfo: ShopifyAdminAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
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

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.ProductPriceRange }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("maxVariantPrice", MaxVariantPrice.self),
      .field("minVariantPrice", MinVariantPrice.self),
    ] }

    /// The highest variant's price.
    public var maxVariantPrice: MaxVariantPrice { __data["maxVariantPrice"] }
    /// The lowest variant's price.
    public var minVariantPrice: MinVariantPrice { __data["minVariantPrice"] }

    /// MaxVariantPrice
    ///
    /// Parent Type: `MoneyV2`
    public struct MaxVariantPrice: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(MoneyInfo.self),
      ] }

      /// Decimal money amount.
      public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
      /// Currency of the money.
      public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var moneyInfo: MoneyInfo { _toFragment() }
      }
    }

    /// MinVariantPrice
    ///
    /// Parent Type: `MoneyV2`
    public struct MinVariantPrice: ShopifyAdminAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAdminAPI.Objects.MoneyV2 }
      public static var __selections: [Apollo.Selection] { [
        .field("__typename", String.self),
        .fragment(MoneyInfo.self),
      ] }

      /// Decimal money amount.
      public var amount: ShopifyAdminAPI.Decimal { __data["amount"] }
      /// Currency of the money.
      public var currencyCode: GraphQLEnum<ShopifyAdminAPI.CurrencyCode> { __data["currencyCode"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var moneyInfo: MoneyInfo { _toFragment() }
      }
    }
  }

}