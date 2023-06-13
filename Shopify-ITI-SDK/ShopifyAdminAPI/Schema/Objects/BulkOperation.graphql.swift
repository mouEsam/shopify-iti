// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// An asynchronous long-running operation to fetch data in bulk or to bulk import data.
  ///
  /// Bulk operations are created using the `bulkOperationRunQuery` or `bulkOperationRunMutation` mutation. After
  /// they are created, clients should poll the `status` field for updates. When `COMPLETED`, the `url` field contains
  /// a link to the data in [JSONL](http://jsonlines.org/) format.
  ///
  /// Refer to the [bulk operations guide](https://shopify.dev/api/usage/bulk-operations/imports) for more details.
  ///
  static let BulkOperation = Object(
    typename: "BulkOperation",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}