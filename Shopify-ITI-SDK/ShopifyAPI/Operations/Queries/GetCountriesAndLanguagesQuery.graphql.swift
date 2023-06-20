// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetCountriesAndLanguagesQuery: GraphQLQuery {
    public static let operationName: String = "getCountriesAndLanguages"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getCountriesAndLanguages($country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          localization {
            __typename
            availableCountries {
              __typename
              currency {
                __typename
                isoCode
                name
                symbol
              }
              isoCode
              name
              unitSystem
            }
            availableLanguages {
              __typename
              isoCode
              endonymName
            }
          }
        }
        """#
      ))

    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("localization", Localization.self),
      ] }

      /// Returns the localized experiences configured for the shop.
      public var localization: Localization { __data["localization"] }

      /// Localization
      ///
      /// Parent Type: `Localization`
      public struct Localization: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Localization }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("availableCountries", [AvailableCountry].self),
          .field("availableLanguages", [AvailableLanguage].self),
        ] }

        /// The list of countries with enabled localized experiences.
        public var availableCountries: [AvailableCountry] { __data["availableCountries"] }
        /// The list of languages available for the active country.
        public var availableLanguages: [AvailableLanguage] { __data["availableLanguages"] }

        /// Localization.AvailableCountry
        ///
        /// Parent Type: `Country`
        public struct AvailableCountry: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Country }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("currency", Currency.self),
            .field("isoCode", GraphQLEnum<ShopifyAPI.CountryCode>.self),
            .field("name", String.self),
            .field("unitSystem", GraphQLEnum<ShopifyAPI.UnitSystem>.self),
          ] }

          /// The currency of the country.
          public var currency: Currency { __data["currency"] }
          /// The ISO code of the country.
          public var isoCode: GraphQLEnum<ShopifyAPI.CountryCode> { __data["isoCode"] }
          /// The name of the country.
          public var name: String { __data["name"] }
          /// The unit system used in the country.
          public var unitSystem: GraphQLEnum<ShopifyAPI.UnitSystem> { __data["unitSystem"] }

          /// Localization.AvailableCountry.Currency
          ///
          /// Parent Type: `Currency`
          public struct Currency: ShopifyAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Currency }
            public static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("isoCode", GraphQLEnum<ShopifyAPI.CurrencyCode>.self),
              .field("name", String.self),
              .field("symbol", String.self),
            ] }

            /// The ISO code of the currency.
            public var isoCode: GraphQLEnum<ShopifyAPI.CurrencyCode> { __data["isoCode"] }
            /// The name of the currency.
            public var name: String { __data["name"] }
            /// The symbol of the currency.
            public var symbol: String { __data["symbol"] }
          }
        }

        /// Localization.AvailableLanguage
        ///
        /// Parent Type: `Language`
        public struct AvailableLanguage: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Language }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("isoCode", GraphQLEnum<ShopifyAPI.LanguageCode>.self),
            .field("endonymName", String.self),
          ] }

          /// The ISO code.
          public var isoCode: GraphQLEnum<ShopifyAPI.LanguageCode> { __data["isoCode"] }
          /// The name of the language in the language itself. If the language uses capitalization, it is capitalized for a mid-sentence position.
          public var endonymName: String { __data["endonymName"] }
        }
      }
    }
  }

}