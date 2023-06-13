// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// <div class="note"><h4>Theme app extensions</h4>
  ///   <p>Your app might not pass App Store review if it uses script tags instead of theme app extensions. All new apps, and apps that integrate with Online Store 2.0 themes, should use theme app extensions, such as app blocks or app embed blocks. Script tags are an alternative you can use with only vintage themes. <a href="/apps/online-store#what-integration-method-should-i-use" target="_blank">Learn more</a>.</p></div>
  ///
  ///
  /// A script tag represents remote JavaScript code that is loaded into the pages of a shop's storefront or the order status page of checkout.
  ///
  static let ScriptTag = Object(
    typename: "ScriptTag",
    implementedInterfaces: [
      ShopifyAdminAPI.Interfaces.LegacyInteroperability.self,
      ShopifyAdminAPI.Interfaces.Node.self
    ]
  )
}