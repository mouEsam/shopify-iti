//
//  PaymantError.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 20/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK

extension ShopifyAdminAPI.CreateDraftOrderMutation.Data.DraftOrderCreate.UserError: GenericErrorConvertible {}
extension ShopifyAdminAPI.CompleteDraftOrderMutation.Data.DraftOrderComplete.UserError: GenericErrorConvertible {}
extension ShopifyAdminAPI.UpdateDraftOrderMutation.Data.DraftOrderUpdate.UserError: GenericErrorConvertible {}
