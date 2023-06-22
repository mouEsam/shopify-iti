//
//  ShopifyErrorText.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import SwiftUI

extension ShopifyErrors {
    var text: Text {
        switch self {
            case .Cancelled:
                fallthrough
            case .Unknown:
                fallthrough
            case .NotFound:
                fallthrough
            case .Unautherized:
                fallthrough
            case .Throttled:
                return Self.error(error: self)
            case .Client(let error):
                if let error = error as? LocalErrors {
                    return error.text
                } else {
                    return error.text
                }
            case .Validation(let errors):
                if let error = errors.first {
                    return Text(error.message)
                } else {
                    return Text("ShopifyErrors.Validation")
                }
            case .Generic(let errors):
                if let error = errors.first {
                    return error.text
                } else {
                    return Text("ShopifyErrors.Generic")
                }
        }
    }
    
    private static func error(error: ShopifyErrors<ErrorCode>) -> Text {
        Text("ShopifyErrors.\(String(describing: error))")
    }
}
