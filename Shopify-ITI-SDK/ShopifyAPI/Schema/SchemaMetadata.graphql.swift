// @generated
// This file was automatically generated and should not be edited.

import Apollo

public protocol ShopifyAPI_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

public protocol ShopifyAPI_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

public protocol ShopifyAPI_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == ShopifyAPI.SchemaMetadata {}

public protocol ShopifyAPI_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == ShopifyAPI.SchemaMetadata {}

public extension ShopifyAPI {
  typealias ID = String

  typealias SelectionSet = ShopifyAPI_SelectionSet

  typealias InlineFragment = ShopifyAPI_InlineFragment

  typealias MutableSelectionSet = ShopifyAPI_MutableSelectionSet

  typealias MutableInlineFragment = ShopifyAPI_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    public static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "QueryRoot": return ShopifyAPI.Objects.QueryRoot
      case "CollectionConnection": return ShopifyAPI.Objects.CollectionConnection
      case "CollectionEdge": return ShopifyAPI.Objects.CollectionEdge
      case "Collection": return ShopifyAPI.Objects.Collection
      case "Article": return ShopifyAPI.Objects.Article
      case "AppliedGiftCard": return ShopifyAPI.Objects.AppliedGiftCard
      case "Blog": return ShopifyAPI.Objects.Blog
      case "Page": return ShopifyAPI.Objects.Page
      case "Product": return ShopifyAPI.Objects.Product
      case "Cart": return ShopifyAPI.Objects.Cart
      case "CartLine": return ShopifyAPI.Objects.CartLine
      case "Checkout": return ShopifyAPI.Objects.Checkout
      case "CheckoutLineItem": return ShopifyAPI.Objects.CheckoutLineItem
      case "Comment": return ShopifyAPI.Objects.Comment
      case "ExternalVideo": return ShopifyAPI.Objects.ExternalVideo
      case "MediaImage": return ShopifyAPI.Objects.MediaImage
      case "Model3d": return ShopifyAPI.Objects.Model3d
      case "Video": return ShopifyAPI.Objects.Video
      case "GenericFile": return ShopifyAPI.Objects.GenericFile
      case "Location": return ShopifyAPI.Objects.Location
      case "MailingAddress": return ShopifyAPI.Objects.MailingAddress
      case "Market": return ShopifyAPI.Objects.Market
      case "MediaPresentation": return ShopifyAPI.Objects.MediaPresentation
      case "Menu": return ShopifyAPI.Objects.Menu
      case "MenuItem": return ShopifyAPI.Objects.MenuItem
      case "Metafield": return ShopifyAPI.Objects.Metafield
      case "Metaobject": return ShopifyAPI.Objects.Metaobject
      case "Order": return ShopifyAPI.Objects.Order
      case "Payment": return ShopifyAPI.Objects.Payment
      case "ProductOption": return ShopifyAPI.Objects.ProductOption
      case "ProductVariant": return ShopifyAPI.Objects.ProductVariant
      case "Shop": return ShopifyAPI.Objects.Shop
      case "ShopPolicy": return ShopifyAPI.Objects.ShopPolicy
      case "UrlRedirect": return ShopifyAPI.Objects.UrlRedirect
      case "Customer": return ShopifyAPI.Objects.Customer
      case "Image": return ShopifyAPI.Objects.Image
      case "ProductConnection": return ShopifyAPI.Objects.ProductConnection
      case "ProductEdge": return ShopifyAPI.Objects.ProductEdge
      case "ProductPriceRange": return ShopifyAPI.Objects.ProductPriceRange
      case "MoneyV2": return ShopifyAPI.Objects.MoneyV2
      case "ProductVariantConnection": return ShopifyAPI.Objects.ProductVariantConnection
      case "PageInfo": return ShopifyAPI.Objects.PageInfo
      case "ImageConnection": return ShopifyAPI.Objects.ImageConnection
      case "Mutation": return ShopifyAPI.Objects.Mutation
      case "CustomerUpdatePayload": return ShopifyAPI.Objects.CustomerUpdatePayload
      case "CustomerAccessToken": return ShopifyAPI.Objects.CustomerAccessToken
      case "CustomerUserError": return ShopifyAPI.Objects.CustomerUserError
      case "CartUserError": return ShopifyAPI.Objects.CartUserError
      case "CheckoutUserError": return ShopifyAPI.Objects.CheckoutUserError
      case "MetafieldDeleteUserError": return ShopifyAPI.Objects.MetafieldDeleteUserError
      case "MetafieldsSetUserError": return ShopifyAPI.Objects.MetafieldsSetUserError
      case "UserError": return ShopifyAPI.Objects.UserError
      case "BaseCartLineConnection": return ShopifyAPI.Objects.BaseCartLineConnection
      case "BaseCartLineEdge": return ShopifyAPI.Objects.BaseCartLineEdge
      case "CartLineCost": return ShopifyAPI.Objects.CartLineCost
      case "CartCost": return ShopifyAPI.Objects.CartCost
      case "CartBuyerIdentity": return ShopifyAPI.Objects.CartBuyerIdentity
      case "CartCreatePayload": return ShopifyAPI.Objects.CartCreatePayload
      case "Attribute": return ShopifyAPI.Objects.Attribute
      case "CartLinesAddPayload": return ShopifyAPI.Objects.CartLinesAddPayload
      case "CartLinesUpdatePayload": return ShopifyAPI.Objects.CartLinesUpdatePayload
      case "CartLinesRemovePayload": return ShopifyAPI.Objects.CartLinesRemovePayload
      case "CartBuyerIdentityUpdatePayload": return ShopifyAPI.Objects.CartBuyerIdentityUpdatePayload
      case "CustomerCreatePayload": return ShopifyAPI.Objects.CustomerCreatePayload
      case "CustomerAccessTokenCreatePayload": return ShopifyAPI.Objects.CustomerAccessTokenCreatePayload
      case "CustomerRecoverPayload": return ShopifyAPI.Objects.CustomerRecoverPayload
      case "CustomerAccessTokenRenewPayload": return ShopifyAPI.Objects.CustomerAccessTokenRenewPayload
      case "CustomerAccessTokenDeletePayload": return ShopifyAPI.Objects.CustomerAccessTokenDeletePayload
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}