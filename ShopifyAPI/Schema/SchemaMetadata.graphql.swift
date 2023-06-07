// @generated
// This file was automatically generated and should not be edited.

import Apollo

protocol ShopifyAPI_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

protocol ShopifyAPI_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

protocol ShopifyAPI_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

protocol ShopifyAPI_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

extension ShopifyAPI {
  typealias ID = String

  typealias SelectionSet = ShopifyAPI_SelectionSet

  typealias InlineFragment = ShopifyAPI_InlineFragment

  typealias MutableSelectionSet = ShopifyAPI_MutableSelectionSet

  typealias MutableInlineFragment = ShopifyAPI_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "QueryRoot": return ShopifyAPI.Objects.QueryRoot
      case "ProductConnection": return ShopifyAPI.Objects.ProductConnection
      case "ProductEdge": return ShopifyAPI.Objects.ProductEdge
      case "Product": return ShopifyAPI.Objects.Product
      case "Article": return ShopifyAPI.Objects.Article
      case "Metafield": return ShopifyAPI.Objects.Metafield
      case "Blog": return ShopifyAPI.Objects.Blog
      case "Collection": return ShopifyAPI.Objects.Collection
      case "Page": return ShopifyAPI.Objects.Page
      case "Cart": return ShopifyAPI.Objects.Cart
      case "MailingAddress": return ShopifyAPI.Objects.MailingAddress
      case "Checkout": return ShopifyAPI.Objects.Checkout
      case "AppliedGiftCard": return ShopifyAPI.Objects.AppliedGiftCard
      case "CheckoutLineItem": return ShopifyAPI.Objects.CheckoutLineItem
      case "ProductVariant": return ShopifyAPI.Objects.ProductVariant
      case "MediaPresentation": return ShopifyAPI.Objects.MediaPresentation
      case "ProductOption": return ShopifyAPI.Objects.ProductOption
      case "Location": return ShopifyAPI.Objects.Location
      case "Order": return ShopifyAPI.Objects.Order
      case "Market": return ShopifyAPI.Objects.Market
      case "Shop": return ShopifyAPI.Objects.Shop
      case "MediaImage": return ShopifyAPI.Objects.MediaImage
      case "Video": return ShopifyAPI.Objects.Video
      case "ExternalVideo": return ShopifyAPI.Objects.ExternalVideo
      case "Model3d": return ShopifyAPI.Objects.Model3d
      case "ShopPolicy": return ShopifyAPI.Objects.ShopPolicy
      case "GenericFile": return ShopifyAPI.Objects.GenericFile
      case "Metaobject": return ShopifyAPI.Objects.Metaobject
      case "Comment": return ShopifyAPI.Objects.Comment
      case "Menu": return ShopifyAPI.Objects.Menu
      case "MenuItem": return ShopifyAPI.Objects.MenuItem
      case "UrlRedirect": return ShopifyAPI.Objects.UrlRedirect
      case "Payment": return ShopifyAPI.Objects.Payment
      case "CartLine": return ShopifyAPI.Objects.CartLine
      case "Customer": return ShopifyAPI.Objects.Customer
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}