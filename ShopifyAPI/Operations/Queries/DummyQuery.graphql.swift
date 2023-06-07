// @generated
// This file was automatically generated and should not be edited.

@_exported import Apollo

extension ShopifyAPI {
  class DummyQuery: GraphQLQuery {
    static let operationName: String = "Dummy"
    static let document: Apollo.DocumentType = .notPersisted(
      definition: .init(
        #"""
        query Dummy {
          products(first: 1) {
            __typename
            edges {
              __typename
              node {
                __typename
                title
              }
            }
          }
        }
        """#
      ))

    public init() {}

    struct Data: ShopifyAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.QueryRoot }
      static var __selections: [Apollo.Selection] { [
        .field("products", Products.self, arguments: ["first": 1]),
      ] }

      /// List of the shop’s products.
      var products: Products { __data["products"] }

      /// Products
      ///
      /// Parent Type: `ProductConnection`
      struct Products: ShopifyAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductConnection }
        static var __selections: [Apollo.Selection] { [
          .field("__typename", String.self),
          .field("edges", [Edge].self),
        ] }

        /// A list of edges.
        var edges: [Edge] { __data["edges"] }

        /// Products.Edge
        ///
        /// Parent Type: `ProductEdge`
        struct Edge: ShopifyAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.ProductEdge }
          static var __selections: [Apollo.Selection] { [
            .field("__typename", String.self),
            .field("node", Node.self),
          ] }

          /// The item at the end of ProductEdge.
          var node: Node { __data["node"] }

          /// Products.Edge.Node
          ///
          /// Parent Type: `Product`
          struct Node: ShopifyAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: Apollo.ParentType { ShopifyAPI.Objects.Product }
            static var __selections: [Apollo.Selection] { [
              .field("__typename", String.self),
              .field("title", String.self),
            ] }

            /// The product’s title.
            var title: String { __data["title"] }
          }
        }
      }
    }
  }

}