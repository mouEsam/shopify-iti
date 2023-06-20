// @generated
// This file was automatically generated and should not be edited.

import Apollo

public protocol ShopifyAdminAPI_SelectionSet: Apollo.SelectionSet & Apollo.RootSelectionSet
where Schema == ShopifyAdminAPI.SchemaMetadata {}

public protocol ShopifyAdminAPI_InlineFragment: Apollo.SelectionSet & Apollo.InlineFragment
where Schema == ShopifyAdminAPI.SchemaMetadata {}

public protocol ShopifyAdminAPI_MutableSelectionSet: Apollo.MutableRootSelectionSet
where Schema == ShopifyAdminAPI.SchemaMetadata {}

public protocol ShopifyAdminAPI_MutableInlineFragment: Apollo.MutableSelectionSet & Apollo.InlineFragment
where Schema == ShopifyAdminAPI.SchemaMetadata {}

public extension ShopifyAdminAPI {
  typealias ID = String

  typealias SelectionSet = ShopifyAdminAPI_SelectionSet

  typealias InlineFragment = ShopifyAdminAPI_InlineFragment

  typealias MutableSelectionSet = ShopifyAdminAPI_MutableSelectionSet

  typealias MutableInlineFragment = ShopifyAdminAPI_MutableInlineFragment

  enum SchemaMetadata: Apollo.SchemaMetadata {
    public static let configuration: Apollo.SchemaConfiguration.Type = SchemaConfiguration.self

    public static func objectType(forTypename typename: String) -> Object? {
      switch typename {
      case "Mutation": return ShopifyAdminAPI.Objects.Mutation
      case "DraftOrderCompletePayload": return ShopifyAdminAPI.Objects.DraftOrderCompletePayload
      case "DraftOrder": return ShopifyAdminAPI.Objects.DraftOrder
      case "Company": return ShopifyAdminAPI.Objects.Company
      case "CompanyLocation": return ShopifyAdminAPI.Objects.CompanyLocation
      case "Collection": return ShopifyAdminAPI.Objects.Collection
      case "AppInstallation": return ShopifyAdminAPI.Objects.AppInstallation
      case "AbandonedCheckout": return ShopifyAdminAPI.Objects.AbandonedCheckout
      case "OnlineStoreArticle": return ShopifyAdminAPI.Objects.OnlineStoreArticle
      case "Link": return ShopifyAdminAPI.Objects.Link
      case "OnlineStoreBlog": return ShopifyAdminAPI.Objects.OnlineStoreBlog
      case "OnlineStorePage": return ShopifyAdminAPI.Objects.OnlineStorePage
      case "Product": return ShopifyAdminAPI.Objects.Product
      case "Customer": return ShopifyAdminAPI.Objects.Customer
      case "Fulfillment": return ShopifyAdminAPI.Objects.Fulfillment
      case "InventoryItem": return ShopifyAdminAPI.Objects.InventoryItem
      case "Location": return ShopifyAdminAPI.Objects.Location
      case "MarketingEvent": return ShopifyAdminAPI.Objects.MarketingEvent
      case "Metafield": return ShopifyAdminAPI.Objects.Metafield
      case "MetafieldStorefrontVisibility": return ShopifyAdminAPI.Objects.MetafieldStorefrontVisibility
      case "Order": return ShopifyAdminAPI.Objects.Order
      case "PriceRule": return ShopifyAdminAPI.Objects.PriceRule
      case "ProductVariant": return ShopifyAdminAPI.Objects.ProductVariant
      case "Refund": return ShopifyAdminAPI.Objects.Refund
      case "SavedSearch": return ShopifyAdminAPI.Objects.SavedSearch
      case "ScriptTag": return ShopifyAdminAPI.Objects.ScriptTag
      case "ShopifyPaymentsDispute": return ShopifyAdminAPI.Objects.ShopifyPaymentsDispute
      case "ShopifyPaymentsPayout": return ShopifyAdminAPI.Objects.ShopifyPaymentsPayout
      case "WebhookSubscription": return ShopifyAdminAPI.Objects.WebhookSubscription
      case "ProductOption": return ShopifyAdminAPI.Objects.ProductOption
      case "Shop": return ShopifyAdminAPI.Objects.Shop
      case "ShopPolicy": return ShopifyAdminAPI.Objects.ShopPolicy
      case "Abandonment": return ShopifyAdminAPI.Objects.Abandonment
      case "AddAllProductsOperation": return ShopifyAdminAPI.Objects.AddAllProductsOperation
      case "CatalogCsvOperation": return ShopifyAdminAPI.Objects.CatalogCsvOperation
      case "PublicationResourceOperation": return ShopifyAdminAPI.Objects.PublicationResourceOperation
      case "AdditionalFee": return ShopifyAdminAPI.Objects.AdditionalFee
      case "App": return ShopifyAdminAPI.Objects.App
      case "AppCatalog": return ShopifyAdminAPI.Objects.AppCatalog
      case "CompanyLocationCatalog": return ShopifyAdminAPI.Objects.CompanyLocationCatalog
      case "MarketCatalog": return ShopifyAdminAPI.Objects.MarketCatalog
      case "AppCredit": return ShopifyAdminAPI.Objects.AppCredit
      case "AppPurchaseOneTime": return ShopifyAdminAPI.Objects.AppPurchaseOneTime
      case "AppRevenueAttributionRecord": return ShopifyAdminAPI.Objects.AppRevenueAttributionRecord
      case "AppSubscription": return ShopifyAdminAPI.Objects.AppSubscription
      case "AppUsageRecord": return ShopifyAdminAPI.Objects.AppUsageRecord
      case "BasicEvent": return ShopifyAdminAPI.Objects.BasicEvent
      case "CommentEvent": return ShopifyAdminAPI.Objects.CommentEvent
      case "BulkOperation": return ShopifyAdminAPI.Objects.BulkOperation
      case "CalculatedOrder": return ShopifyAdminAPI.Objects.CalculatedOrder
      case "Channel": return ShopifyAdminAPI.Objects.Channel
      case "ChannelDefinition": return ShopifyAdminAPI.Objects.ChannelDefinition
      case "ChannelInformation": return ShopifyAdminAPI.Objects.ChannelInformation
      case "CheckoutProfile": return ShopifyAdminAPI.Objects.CheckoutProfile
      case "CompanyAddress": return ShopifyAdminAPI.Objects.CompanyAddress
      case "CompanyContact": return ShopifyAdminAPI.Objects.CompanyContact
      case "CompanyContactRole": return ShopifyAdminAPI.Objects.CompanyContactRole
      case "CompanyContactRoleAssignment": return ShopifyAdminAPI.Objects.CompanyContactRoleAssignment
      case "CustomerPaymentMethod": return ShopifyAdminAPI.Objects.CustomerPaymentMethod
      case "CustomerSegmentMembersQuery": return ShopifyAdminAPI.Objects.CustomerSegmentMembersQuery
      case "CustomerVisit": return ShopifyAdminAPI.Objects.CustomerVisit
      case "DeliveryCarrierService": return ShopifyAdminAPI.Objects.DeliveryCarrierService
      case "DeliveryCondition": return ShopifyAdminAPI.Objects.DeliveryCondition
      case "DeliveryCountry": return ShopifyAdminAPI.Objects.DeliveryCountry
      case "DeliveryCustomization": return ShopifyAdminAPI.Objects.DeliveryCustomization
      case "DeliveryLocationGroup": return ShopifyAdminAPI.Objects.DeliveryLocationGroup
      case "DeliveryMethod": return ShopifyAdminAPI.Objects.DeliveryMethod
      case "DeliveryMethodDefinition": return ShopifyAdminAPI.Objects.DeliveryMethodDefinition
      case "DeliveryParticipant": return ShopifyAdminAPI.Objects.DeliveryParticipant
      case "DeliveryProfile": return ShopifyAdminAPI.Objects.DeliveryProfile
      case "DeliveryProfileItem": return ShopifyAdminAPI.Objects.DeliveryProfileItem
      case "DeliveryProvince": return ShopifyAdminAPI.Objects.DeliveryProvince
      case "DeliveryRateDefinition": return ShopifyAdminAPI.Objects.DeliveryRateDefinition
      case "DeliveryZone": return ShopifyAdminAPI.Objects.DeliveryZone
      case "DiscountAutomaticBxgy": return ShopifyAdminAPI.Objects.DiscountAutomaticBxgy
      case "DiscountAutomaticNode": return ShopifyAdminAPI.Objects.DiscountAutomaticNode
      case "DiscountCodeNode": return ShopifyAdminAPI.Objects.DiscountCodeNode
      case "DiscountNode": return ShopifyAdminAPI.Objects.DiscountNode
      case "DiscountRedeemCodeBulkCreation": return ShopifyAdminAPI.Objects.DiscountRedeemCodeBulkCreation
      case "Domain": return ShopifyAdminAPI.Objects.Domain
      case "DraftOrderLineItem": return ShopifyAdminAPI.Objects.DraftOrderLineItem
      case "DraftOrderTag": return ShopifyAdminAPI.Objects.DraftOrderTag
      case "Duty": return ShopifyAdminAPI.Objects.Duty
      case "ExternalVideo": return ShopifyAdminAPI.Objects.ExternalVideo
      case "MediaImage": return ShopifyAdminAPI.Objects.MediaImage
      case "GenericFile": return ShopifyAdminAPI.Objects.GenericFile
      case "Video": return ShopifyAdminAPI.Objects.Video
      case "Model3d": return ShopifyAdminAPI.Objects.Model3d
      case "FulfillmentEvent": return ShopifyAdminAPI.Objects.FulfillmentEvent
      case "FulfillmentLineItem": return ShopifyAdminAPI.Objects.FulfillmentLineItem
      case "FulfillmentOrder": return ShopifyAdminAPI.Objects.FulfillmentOrder
      case "FulfillmentOrderDestination": return ShopifyAdminAPI.Objects.FulfillmentOrderDestination
      case "FulfillmentOrderLineItem": return ShopifyAdminAPI.Objects.FulfillmentOrderLineItem
      case "FulfillmentOrderMerchantRequest": return ShopifyAdminAPI.Objects.FulfillmentOrderMerchantRequest
      case "GiftCard": return ShopifyAdminAPI.Objects.GiftCard
      case "InventoryAdjustmentGroup": return ShopifyAdminAPI.Objects.InventoryAdjustmentGroup
      case "InventoryLevel": return ShopifyAdminAPI.Objects.InventoryLevel
      case "LineItem": return ShopifyAdminAPI.Objects.LineItem
      case "LineItemMutable": return ShopifyAdminAPI.Objects.LineItemMutable
      case "MailingAddress": return ShopifyAdminAPI.Objects.MailingAddress
      case "Market": return ShopifyAdminAPI.Objects.Market
      case "MarketRegionCountry": return ShopifyAdminAPI.Objects.MarketRegionCountry
      case "MarketWebPresence": return ShopifyAdminAPI.Objects.MarketWebPresence
      case "MarketingActivity": return ShopifyAdminAPI.Objects.MarketingActivity
      case "MetafieldDefinition": return ShopifyAdminAPI.Objects.MetafieldDefinition
      case "Metaobject": return ShopifyAdminAPI.Objects.Metaobject
      case "MetaobjectDefinition": return ShopifyAdminAPI.Objects.MetaobjectDefinition
      case "OrderDisputeSummary": return ShopifyAdminAPI.Objects.OrderDisputeSummary
      case "OrderTransaction": return ShopifyAdminAPI.Objects.OrderTransaction
      case "PaymentCustomization": return ShopifyAdminAPI.Objects.PaymentCustomization
      case "PaymentMandate": return ShopifyAdminAPI.Objects.PaymentMandate
      case "PaymentSchedule": return ShopifyAdminAPI.Objects.PaymentSchedule
      case "PaymentTerms": return ShopifyAdminAPI.Objects.PaymentTerms
      case "PaymentTermsTemplate": return ShopifyAdminAPI.Objects.PaymentTermsTemplate
      case "PriceList": return ShopifyAdminAPI.Objects.PriceList
      case "PriceRuleDiscountCode": return ShopifyAdminAPI.Objects.PriceRuleDiscountCode
      case "PrivateMetafield": return ShopifyAdminAPI.Objects.PrivateMetafield
      case "ProductTaxonomyNode": return ShopifyAdminAPI.Objects.ProductTaxonomyNode
      case "Publication": return ShopifyAdminAPI.Objects.Publication
      case "Return": return ShopifyAdminAPI.Objects.Return
      case "ReturnLineItem": return ShopifyAdminAPI.Objects.ReturnLineItem
      case "ReturnableFulfillment": return ShopifyAdminAPI.Objects.ReturnableFulfillment
      case "ReverseDelivery": return ShopifyAdminAPI.Objects.ReverseDelivery
      case "ReverseDeliveryLineItem": return ShopifyAdminAPI.Objects.ReverseDeliveryLineItem
      case "ReverseFulfillmentOrder": return ShopifyAdminAPI.Objects.ReverseFulfillmentOrder
      case "ReverseFulfillmentOrderDisposition": return ShopifyAdminAPI.Objects.ReverseFulfillmentOrderDisposition
      case "ReverseFulfillmentOrderLineItem": return ShopifyAdminAPI.Objects.ReverseFulfillmentOrderLineItem
      case "Segment": return ShopifyAdminAPI.Objects.Segment
      case "SellingPlan": return ShopifyAdminAPI.Objects.SellingPlan
      case "SellingPlanGroup": return ShopifyAdminAPI.Objects.SellingPlanGroup
      case "ServerPixel": return ShopifyAdminAPI.Objects.ServerPixel
      case "ShopAddress": return ShopifyAdminAPI.Objects.ShopAddress
      case "ShopifyPaymentsAccount": return ShopifyAdminAPI.Objects.ShopifyPaymentsAccount
      case "ShopifyPaymentsBankAccount": return ShopifyAdminAPI.Objects.ShopifyPaymentsBankAccount
      case "ShopifyPaymentsDisputeEvidence": return ShopifyAdminAPI.Objects.ShopifyPaymentsDisputeEvidence
      case "ShopifyPaymentsDisputeFileUpload": return ShopifyAdminAPI.Objects.ShopifyPaymentsDisputeFileUpload
      case "ShopifyPaymentsDisputeFulfillment": return ShopifyAdminAPI.Objects.ShopifyPaymentsDisputeFulfillment
      case "ShopifyPaymentsVerification": return ShopifyAdminAPI.Objects.ShopifyPaymentsVerification
      case "StaffMember": return ShopifyAdminAPI.Objects.StaffMember
      case "StandardMetafieldDefinitionTemplate": return ShopifyAdminAPI.Objects.StandardMetafieldDefinitionTemplate
      case "StorefrontAccessToken": return ShopifyAdminAPI.Objects.StorefrontAccessToken
      case "SubscriptionBillingAttempt": return ShopifyAdminAPI.Objects.SubscriptionBillingAttempt
      case "SubscriptionContract": return ShopifyAdminAPI.Objects.SubscriptionContract
      case "SubscriptionBillingCycleEditedContract": return ShopifyAdminAPI.Objects.SubscriptionBillingCycleEditedContract
      case "SubscriptionDraft": return ShopifyAdminAPI.Objects.SubscriptionDraft
      case "TenderTransaction": return ShopifyAdminAPI.Objects.TenderTransaction
      case "TransactionFee": return ShopifyAdminAPI.Objects.TransactionFee
      case "UrlRedirect": return ShopifyAdminAPI.Objects.UrlRedirect
      case "UrlRedirectImport": return ShopifyAdminAPI.Objects.UrlRedirectImport
      case "WebPixel": return ShopifyAdminAPI.Objects.WebPixel
      case "Image": return ShopifyAdminAPI.Objects.Image
      case "UserError": return ShopifyAdminAPI.Objects.UserError
      case "AbandonmentEmailStateUpdateUserError": return ShopifyAdminAPI.Objects.AbandonmentEmailStateUpdateUserError
      case "AppRevenueAttributionRecordCreateUserError": return ShopifyAdminAPI.Objects.AppRevenueAttributionRecordCreateUserError
      case "AppRevenueAttributionRecordDeleteUserError": return ShopifyAdminAPI.Objects.AppRevenueAttributionRecordDeleteUserError
      case "AppSubscriptionTrialExtendUserError": return ShopifyAdminAPI.Objects.AppSubscriptionTrialExtendUserError
      case "BillingAttemptUserError": return ShopifyAdminAPI.Objects.BillingAttemptUserError
      case "BulkMutationUserError": return ShopifyAdminAPI.Objects.BulkMutationUserError
      case "BulkProductResourceFeedbackCreateUserError": return ShopifyAdminAPI.Objects.BulkProductResourceFeedbackCreateUserError
      case "BusinessCustomerUserError": return ShopifyAdminAPI.Objects.BusinessCustomerUserError
      case "CatalogUserError": return ShopifyAdminAPI.Objects.CatalogUserError
      case "CollectionAddProductsV2UserError": return ShopifyAdminAPI.Objects.CollectionAddProductsV2UserError
      case "CustomerEmailMarketingConsentUpdateUserError": return ShopifyAdminAPI.Objects.CustomerEmailMarketingConsentUpdateUserError
      case "CustomerMergeUserError": return ShopifyAdminAPI.Objects.CustomerMergeUserError
      case "CustomerPaymentMethodGetUpdateUrlUserError": return ShopifyAdminAPI.Objects.CustomerPaymentMethodGetUpdateUrlUserError
      case "CustomerPaymentMethodRemoteUserError": return ShopifyAdminAPI.Objects.CustomerPaymentMethodRemoteUserError
      case "CustomerPaymentMethodUserError": return ShopifyAdminAPI.Objects.CustomerPaymentMethodUserError
      case "CustomerSegmentMembersQueryUserError": return ShopifyAdminAPI.Objects.CustomerSegmentMembersQueryUserError
      case "CustomerSmsMarketingConsentError": return ShopifyAdminAPI.Objects.CustomerSmsMarketingConsentError
      case "DelegateAccessTokenCreateUserError": return ShopifyAdminAPI.Objects.DelegateAccessTokenCreateUserError
      case "DelegateAccessTokenDestroyUserError": return ShopifyAdminAPI.Objects.DelegateAccessTokenDestroyUserError
      case "DeliveryCustomizationError": return ShopifyAdminAPI.Objects.DeliveryCustomizationError
      case "DeliveryLocationLocalPickupSettingsError": return ShopifyAdminAPI.Objects.DeliveryLocationLocalPickupSettingsError
      case "DiscountUserError": return ShopifyAdminAPI.Objects.DiscountUserError
      case "DisputeEvidenceUpdateUserError": return ShopifyAdminAPI.Objects.DisputeEvidenceUpdateUserError
      case "ErrorsServerPixelUserError": return ShopifyAdminAPI.Objects.ErrorsServerPixelUserError
      case "ErrorsWebPixelUserError": return ShopifyAdminAPI.Objects.ErrorsWebPixelUserError
      case "FilesUserError": return ShopifyAdminAPI.Objects.FilesUserError
      case "FulfillmentOrderHoldUserError": return ShopifyAdminAPI.Objects.FulfillmentOrderHoldUserError
      case "FulfillmentOrderLineItemsPreparedForPickupUserError": return ShopifyAdminAPI.Objects.FulfillmentOrderLineItemsPreparedForPickupUserError
      case "FulfillmentOrderReleaseHoldUserError": return ShopifyAdminAPI.Objects.FulfillmentOrderReleaseHoldUserError
      case "FulfillmentOrderRescheduleUserError": return ShopifyAdminAPI.Objects.FulfillmentOrderRescheduleUserError
      case "FulfillmentOrdersReleaseHoldsUserError": return ShopifyAdminAPI.Objects.FulfillmentOrdersReleaseHoldsUserError
      case "FulfillmentOrdersSetFulfillmentDeadlineUserError": return ShopifyAdminAPI.Objects.FulfillmentOrdersSetFulfillmentDeadlineUserError
      case "GiftCardUserError": return ShopifyAdminAPI.Objects.GiftCardUserError
      case "InventoryAdjustQuantitiesUserError": return ShopifyAdminAPI.Objects.InventoryAdjustQuantitiesUserError
      case "InventoryBulkToggleActivationUserError": return ShopifyAdminAPI.Objects.InventoryBulkToggleActivationUserError
      case "InventoryMoveQuantitiesUserError": return ShopifyAdminAPI.Objects.InventoryMoveQuantitiesUserError
      case "InventorySetOnHandQuantitiesUserError": return ShopifyAdminAPI.Objects.InventorySetOnHandQuantitiesUserError
      case "LocationActivateUserError": return ShopifyAdminAPI.Objects.LocationActivateUserError
      case "LocationAddUserError": return ShopifyAdminAPI.Objects.LocationAddUserError
      case "LocationDeactivateUserError": return ShopifyAdminAPI.Objects.LocationDeactivateUserError
      case "LocationDeleteUserError": return ShopifyAdminAPI.Objects.LocationDeleteUserError
      case "LocationEditUserError": return ShopifyAdminAPI.Objects.LocationEditUserError
      case "MarketCurrencySettingsUserError": return ShopifyAdminAPI.Objects.MarketCurrencySettingsUserError
      case "MarketUserError": return ShopifyAdminAPI.Objects.MarketUserError
      case "MarketingActivityUserError": return ShopifyAdminAPI.Objects.MarketingActivityUserError
      case "MediaUserError": return ShopifyAdminAPI.Objects.MediaUserError
      case "MetafieldDefinitionCreateUserError": return ShopifyAdminAPI.Objects.MetafieldDefinitionCreateUserError
      case "MetafieldDefinitionDeleteUserError": return ShopifyAdminAPI.Objects.MetafieldDefinitionDeleteUserError
      case "MetafieldDefinitionPinUserError": return ShopifyAdminAPI.Objects.MetafieldDefinitionPinUserError
      case "MetafieldDefinitionUnpinUserError": return ShopifyAdminAPI.Objects.MetafieldDefinitionUnpinUserError
      case "MetafieldDefinitionUpdateUserError": return ShopifyAdminAPI.Objects.MetafieldDefinitionUpdateUserError
      case "MetafieldsSetUserError": return ShopifyAdminAPI.Objects.MetafieldsSetUserError
      case "MetaobjectUserError": return ShopifyAdminAPI.Objects.MetaobjectUserError
      case "OrderCreateMandatePaymentUserError": return ShopifyAdminAPI.Objects.OrderCreateMandatePaymentUserError
      case "OrderInvoiceSendUserError": return ShopifyAdminAPI.Objects.OrderInvoiceSendUserError
      case "PaymentCustomizationError": return ShopifyAdminAPI.Objects.PaymentCustomizationError
      case "PaymentReminderSendUserError": return ShopifyAdminAPI.Objects.PaymentReminderSendUserError
      case "PaymentTermsCreateUserError": return ShopifyAdminAPI.Objects.PaymentTermsCreateUserError
      case "PaymentTermsDeleteUserError": return ShopifyAdminAPI.Objects.PaymentTermsDeleteUserError
      case "PaymentTermsUpdateUserError": return ShopifyAdminAPI.Objects.PaymentTermsUpdateUserError
      case "PriceListPriceUserError": return ShopifyAdminAPI.Objects.PriceListPriceUserError
      case "PriceListUserError": return ShopifyAdminAPI.Objects.PriceListUserError
      case "PriceRuleUserError": return ShopifyAdminAPI.Objects.PriceRuleUserError
      case "ProductChangeStatusUserError": return ShopifyAdminAPI.Objects.ProductChangeStatusUserError
      case "ProductDeleteUserError": return ShopifyAdminAPI.Objects.ProductDeleteUserError
      case "ProductDuplicateUserError": return ShopifyAdminAPI.Objects.ProductDuplicateUserError
      case "ProductVariantsBulkCreateUserError": return ShopifyAdminAPI.Objects.ProductVariantsBulkCreateUserError
      case "ProductVariantsBulkDeleteUserError": return ShopifyAdminAPI.Objects.ProductVariantsBulkDeleteUserError
      case "ProductVariantsBulkReorderUserError": return ShopifyAdminAPI.Objects.ProductVariantsBulkReorderUserError
      case "ProductVariantsBulkUpdateUserError": return ShopifyAdminAPI.Objects.ProductVariantsBulkUpdateUserError
      case "PubSubWebhookSubscriptionCreateUserError": return ShopifyAdminAPI.Objects.PubSubWebhookSubscriptionCreateUserError
      case "PubSubWebhookSubscriptionUpdateUserError": return ShopifyAdminAPI.Objects.PubSubWebhookSubscriptionUpdateUserError
      case "PublicationUserError": return ShopifyAdminAPI.Objects.PublicationUserError
      case "ReturnUserError": return ShopifyAdminAPI.Objects.ReturnUserError
      case "SellingPlanGroupUserError": return ShopifyAdminAPI.Objects.SellingPlanGroupUserError
      case "ShopPolicyUserError": return ShopifyAdminAPI.Objects.ShopPolicyUserError
      case "ShopResourceFeedbackCreateUserError": return ShopifyAdminAPI.Objects.ShopResourceFeedbackCreateUserError
      case "StandardMetafieldDefinitionEnableUserError": return ShopifyAdminAPI.Objects.StandardMetafieldDefinitionEnableUserError
      case "SubscriptionBillingCycleUserError": return ShopifyAdminAPI.Objects.SubscriptionBillingCycleUserError
      case "SubscriptionContractUserError": return ShopifyAdminAPI.Objects.SubscriptionContractUserError
      case "SubscriptionDraftUserError": return ShopifyAdminAPI.Objects.SubscriptionDraftUserError
      case "TranslationUserError": return ShopifyAdminAPI.Objects.TranslationUserError
      case "UrlRedirectBulkDeleteByIdsUserError": return ShopifyAdminAPI.Objects.UrlRedirectBulkDeleteByIdsUserError
      case "UrlRedirectBulkDeleteBySavedSearchUserError": return ShopifyAdminAPI.Objects.UrlRedirectBulkDeleteBySavedSearchUserError
      case "UrlRedirectBulkDeleteBySearchUserError": return ShopifyAdminAPI.Objects.UrlRedirectBulkDeleteBySearchUserError
      case "UrlRedirectImportUserError": return ShopifyAdminAPI.Objects.UrlRedirectImportUserError
      case "UrlRedirectUserError": return ShopifyAdminAPI.Objects.UrlRedirectUserError
      case "DraftOrderCreatePayload": return ShopifyAdminAPI.Objects.DraftOrderCreatePayload
      case "DraftOrderUpdatePayload": return ShopifyAdminAPI.Objects.DraftOrderUpdatePayload
      case "MoneyBag": return ShopifyAdminAPI.Objects.MoneyBag
      case "MoneyV2": return ShopifyAdminAPI.Objects.MoneyV2
      case "DraftOrderLineItemConnection": return ShopifyAdminAPI.Objects.DraftOrderLineItemConnection
      case "PageInfo": return ShopifyAdminAPI.Objects.PageInfo
      case "DraftOrderDeletePayload": return ShopifyAdminAPI.Objects.DraftOrderDeletePayload
      case "QueryRoot": return ShopifyAdminAPI.Objects.QueryRoot
      case "DraftOrderConnection": return ShopifyAdminAPI.Objects.DraftOrderConnection
      case "DraftOrderLineItemEdge": return ShopifyAdminAPI.Objects.DraftOrderLineItemEdge
      case "ProductPriceRange": return ShopifyAdminAPI.Objects.ProductPriceRange
      case "ProductVariantConnection": return ShopifyAdminAPI.Objects.ProductVariantConnection
      case "ProductVariantContextualPricing": return ShopifyAdminAPI.Objects.ProductVariantContextualPricing
      default: return nil
      }
    }
  }

  enum Objects {}
  enum Interfaces {}
  enum Unions {}

}