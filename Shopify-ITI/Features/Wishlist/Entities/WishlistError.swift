//
//  WishlistError.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK

extension ShopifyAdminAPI.CreateWishlistMutation.Data.DraftOrderCreate.UserError: GenericErrorConvertible {}
extension ShopifyAdminAPI.DeleteWishlistMutation.Data.DraftOrderDelete.UserError: GenericErrorConvertible {}
