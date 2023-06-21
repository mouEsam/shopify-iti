//
//  ErrorText.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import SwiftUI
import Shopify_ITI_SDK

extension Error {
    var text: Text {
        if let error = self as? LocalErrors {
            return error.text
        } else if let error = self as? GenericError {
            return error.text
        } else if let error = self as? ShopifyErrors<Any> {
            return error.text
        } else if let error = self as? ShopifyErrors<ShopifyAPI.CustomerErrorCode> {
            return error.text
        } else {
            return Text(self.localizedDescription)
        }
    }
}
