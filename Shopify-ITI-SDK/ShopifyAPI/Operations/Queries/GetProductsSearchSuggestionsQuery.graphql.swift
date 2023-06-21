// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  class GetProductsSearchSuggestionsQuery: GraphQLQuery {
    public static let operationName: String = "getProductsSearchSuggestions"
    public static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query getProductsSearchSuggestions($query: String!, $country: CountryCode, $lang: LanguageCode) @inContext(country: $country, language: $lang) {
          predictiveSearch(query: $query) {
            __typename
            queries {
              __typename
              text
            }
          }
        }
        """#
      ))

    public var query: String
    public var country: GraphQLNullable<GraphQLEnum<CountryCode>>
    public var lang: GraphQLNullable<GraphQLEnum<LanguageCode>>

    public init(
      query: String,
      country: GraphQLNullable<GraphQLEnum<CountryCode>>,
      lang: GraphQLNullable<GraphQLEnum<LanguageCode>>
    ) {
      self.query = query
      self.country = country
      self.lang = lang
    }

    public var __variables: Variables? { [
      "query": query,
      "country": country,
      "lang": lang
    ] }

    public struct Data: ShopifyAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      public static var __selections: [Apollo.Selection] { [
        .field("predictiveSearch", PredictiveSearch?.self, arguments: ["query": .variable("query")]),
      ] }

      /// List of the predictive search results.
      public var predictiveSearch: PredictiveSearch? { __data["predictiveSearch"] }

      /// PredictiveSearch
      ///
      /// Parent Type: `PredictiveSearchResult`
      public struct PredictiveSearch: ShopifyAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.PredictiveSearchResult }
        public static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("queries", [Query].self),
        ] }

        /// The query suggestions that are relevant to the search query.
        public var queries: [Query] { __data["queries"] }

        /// PredictiveSearch.Query
        ///
        /// Parent Type: `SearchQuerySuggestion`
        public struct Query: ShopifyAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.SearchQuerySuggestion }
          public static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("text", String.self),
          ] }

          /// The text of the search query suggestion.
          public var text: String { __data["text"] }
        }
      }
    }
  }

}