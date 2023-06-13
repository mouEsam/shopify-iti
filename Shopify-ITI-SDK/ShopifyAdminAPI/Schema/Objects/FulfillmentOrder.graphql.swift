// @generated
// This file was automatically generated and should not be edited.

import Apollo

public extension ShopifyAdminAPI.Objects {
  /// The FulfillmentOrder object represents either an item or a group of items in an
  /// [Order](https://shopify.dev/api/admin-graphql/latest/objects/Order)
  /// that are expected to be fulfilled from the same location.
  /// There can be more than one fulfillment order for an
  /// [order](https://shopify.dev/api/admin-graphql/latest/objects/Order)
  /// at a given location.
  ///
  /// {{ '/api/reference/fulfillment_order_relationships.png' | image }}
  ///
  /// Fulfillment orders represent the work which is intended to be done in relation to an order.
  /// When fulfillment has started for one or more line items, a
  /// [Fulfillment](https://shopify.dev/api/admin-graphql/latest/objects/Fulfillment)
  /// is created by a merchant or third party to represent the ongoing or completed work of fulfillment.
  ///
  /// [See below for more details on creating fulfillments](#the-lifecycle-of-a-fulfillment-order-at-a-location-which-is-managed-by-a-fulfillment-service).
  ///
  /// > Note:
  /// > Shopify creates fulfillment orders automatically when an order is created.
  /// > It is not possible to manually create fulfillment orders.
  /// >
  /// > [See below for more details on the lifecycle of a fulfillment order](#the-lifecycle-of-a-fulfillment-order).
  ///
  /// ## Retrieving fulfillment orders
  ///
  /// All fulfillment orders related to a given order can be retrieved with the
  /// [Order.fulfillmentOrders](https://shopify.dev/api/admin-graphql/latest/objects/Order#connection-order-fulfillmentorders)
  /// connection.
  ///
  /// [API access scopes](#api-access-scopes)
  /// govern which fulfillments orders are returned to clients.
  /// An API client will only receive a subset of the fulfillment orders which belong to an order
  /// if they don't have the necessary access scopes to view all of the fulfillment orders.
  ///
  /// Fulfillment service apps can retrieve the fulfillment orders which have been assigned to their locations with the
  /// [Shop.assignedFulfillmentOrders](https://shopify.dev/api/admin-graphql/latest/objects/Shop#connection-shop-assignedfulfillmentorders)
  /// connection.
  /// Use the `assignmentStatus` argument to control whether all assigned fulfillment orders
  /// should be returned or only those where a merchant has sent a
  /// [fulfillment request](https://shopify.dev/api/admin-graphql/latest/objects/FulfillmentOrderMerchantRequest)
  /// and it has yet to be responded to.
  ///
  /// The API client must be granted the `read_assigned_fulfillment_orders` access scope to access
  /// the assigned fulfillment orders.
  ///
  /// ## The lifecycle of a fulfillment order
  ///
  /// ### Fulfillment Order Creation
  ///
  /// After an order is created, a background worker performs the order routing process which determines
  /// which locations will be responsible for fulfilling the purchased items.
  /// Once the order routing process is complete, one or more fulfillment orders will be created
  /// and assigned to these locations. It is not possible to manually create fulfillment orders.
  ///
  /// Once a fulfillment order has been created, it will have one of two different lifecycles depending on
  /// the type of location which the fulfillment order is assigned to.
  ///
  /// ### The lifecycle of a fulfillment order at a merchant managed location
  ///
  /// Fulfillment orders are completed by creating
  /// [fulfillments](https://shopify.dev/api/admin-graphql/latest/objects/Fulfillment).
  /// Fulfillments represents the work done.
  ///
  /// For digital products a merchant or an order management app would create a fulfilment once the digital asset
  /// has been provisioned.
  /// For example, in the case of a digital gift card, a merchant would to do this once
  /// the gift card has been activated - before the email has been shipped.
  ///
  /// On the other hand, for a traditional shipped order,
  /// a merchant or an order management app would create a fulfillment after picking and packing the items relating
  /// to a fulfillment order, but before the courier has collected the goods.
  ///
  /// [Learn about managing fulfillment orders as an order management app](https://shopify.dev/apps/fulfillment/order-management-apps/manage-fulfillments).
  ///
  /// ### The lifecycle of a fulfillment order at a location which is managed by a fulfillment service
  ///
  /// For fulfillment orders which are assigned to a location that is managed by a fulfillment service,
  /// a merchant or an Order Management App can
  /// [send a fulfillment request](https://shopify.dev/api/admin-graphql/latest/mutations/fulfillmentOrderSubmitFulfillmentRequest)
  /// to the fulfillment service which operates the location to request that they fulfill the associated items.
  /// A fulfillment service has the option to
  /// [accept](https://shopify.dev/api/admin-graphql/latest/mutations/fulfillmentOrderAcceptFulfillmentRequest)
  /// or [reject](https://shopify.dev/api/admin-graphql/latest/mutations/fulfillmentOrderRejectFulfillmentRequest)
  /// this fulfillment request.
  ///
  /// Once the fulfillment service has accepted the request, the request can no longer be cancelled by the merchant
  /// or order management app and instead a
  /// [cancellation request must be submitted](https://shopify.dev/api/admin-graphql/latest/mutations/fulfillmentOrderSubmitCancellationRequest)
  /// to the fulfillment service.
  ///
  /// Once a fulfillment service accepts a fulfillment request,
  /// then after they are ready to pack items and send them for delivery, they create fulfillments with the
  /// [fulfillmentCreateV2](https://shopify.dev/api/admin-graphql/latest/mutations/fulfillmentCreateV2)
  /// mutation.
  /// They can provide tracking information right away or create fulfillments without it and then
  /// update the tracking information for fulfillments with the
  /// [fulfillmentTrackingInfoUpdateV2](https://shopify.dev/api/admin-graphql/latest/mutations/fulfillmentTrackingInfoUpdateV2)
  /// mutation.
  ///
  /// [Learn about managing fulfillment orders as a fulfillment service](https://shopify.dev/apps/fulfillment/fulfillment-service-apps/manage-fulfillments).
  ///
  /// ## API access scopes
  ///
  /// Fulfillment orders are governed by the following API access scopes:
  ///
  /// * The `read_merchant_managed_fulfillment_orders` and
  ///   `write_merchant_managed_fulfillment_orders` access scopes
  ///   grant access to fulfillment orders assigned to merchant-managed locations.
  /// * The `read_assigned_fulfillment_orders` and `write_assigned_fulfillment_orders`
  ///   access scopes are intended for fulfillment services.
  ///   These scopes grant access to fulfillment orders assigned to locations that are being managed
  ///   by fulfillment services.
  /// * The `read_third_party_fulfillment_orders` and `write_third_party_fulfillment_orders`
  ///   access scopes grant access to fulfillment orders
  ///   assigned to locations managed by other fulfillment services.
  ///
  /// ### Fulfillment service app access scopes
  ///
  /// Usually, **fulfillment services** have the `write_assigned_fulfillment_orders` access scope
  /// and don't have the `*_third_party_fulfillment_orders`
  /// or `*_merchant_managed_fulfillment_orders` access scopes.
  /// The app will only have access to the fulfillment orders assigned to their location
  /// (or multiple locations if the app registers multiple fulfillment services on the shop).
  /// The app will not have access to fulfillment orders assigned to merchant-managed locations
  /// or locations owned by other fulfillment service apps.
  ///
  /// ### Order management app access scopes
  ///
  /// **Order management apps** will usually request `write_merchant_managed_fulfillment_orders` and
  /// `write_third_party_fulfillment_orders` access scopes. This will allow them to manage all fulfillment orders
  /// on behalf of a merchant.
  ///
  /// If an app combines the functions of an order management app and a fulfillment service,
  /// then the app should request all
  /// access scopes to manage all assigned and all unassigned fulfillment orders.
  ///
  /// ## Notifications about fulfillment orders
  ///
  /// Fulfillment services are required to
  /// [register](https://shopify.dev/api/admin-graphql/latest/objects/FulfillmentService)
  /// a self-hosted callback URL which has a number of uses. One of these uses is that this callback URL will be notified
  /// whenever a merchant submits a fulfillment or cancellation request.
  ///
  /// Both merchants and apps can
  /// [subscribe](https://shopify.dev/apps/fulfillment/fulfillment-service-apps/manage-fulfillments#webhooks)
  /// to the
  /// [fulfillment order webhooks](https://shopify.dev/api/admin-graphql/latest/enums/WebhookSubscriptionTopic#value-fulfillmentorderscancellationrequestaccepted)
  /// to be notified whenever fulfillment order related domain events occur.
  ///
  /// [Learn about fulfillment workflows](https://shopify.dev/apps/fulfillment).
  ///
  static let FulfillmentOrder = Object(
    typename: "FulfillmentOrder",
    implementedInterfaces: [ShopifyAdminAPI.Interfaces.Node.self]
  )
}