// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

public extension ShopifyAPI {
  struct PaginationInfo: ShopifyAPI.SelectionSet, Fragment {
    public static var fragmentDefinition: StaticString { """
      fragment paginationInfo on PageInfo {
        __typename
        startCursor
        endCursor
        hasNextPage
        hasPreviousPage
      }
      """ }

    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.PageInfo }
    public static var __selections: [Apollo.Selection] { [
      .field("__typename", String.self),
      .field("startCursor", String?.self),
      .field("endCursor", String?.self),
      .field("hasNextPage", Bool.self),
      .field("hasPreviousPage", Bool.self),
    ] }

    /// The cursor corresponding to the first node in edges.
    public var startCursor: String? { __data["startCursor"] }
    /// The cursor corresponding to the last node in edges.
    public var endCursor: String? { __data["endCursor"] }
    /// Whether there are more pages to fetch following the current page.
    public var hasNextPage: Bool { __data["hasNextPage"] }
    /// Whether there are any pages prior to the current page.
    public var hasPreviousPage: Bool { __data["hasPreviousPage"] }
  }

}