// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// The market’s web presence, which defines its SEO strategy. This can be a different domain
  /// (e.g. `example.ca`), subdomain (e.g. `ca.example.com`), or subfolders of the primary
  /// domain (e.g. `example.com/en-ca`). Each web presence comprises one or more language
  /// variants. If a market does not have its own web presence, it is accessible on the shop’s
  /// primary domain via [country
  /// selectors](https://shopify.dev/themes/internationalization/multiple-currencies-languages#the-country-selector).
  ///
  /// Note: while the domain/subfolders defined by a market’s web presence are not applicable to
  /// custom storefronts, which must manage their own domains and routing, the languages chosen
  /// here do govern [the languages available on the Storefront
  /// API](https://shopify.dev/custom-storefronts/internationalization/multiple-languages) for the countries in
  /// this market.
  ///
  static let MarketWebPresence = Object(
    typename: "MarketWebPresence",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}