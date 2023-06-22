//
//  ShopifyErrorView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import SwiftUI

struct ShopifyErrorView<ErrorCode, Content: View>: View {
    
    private let error: ShopifyErrors<ErrorCode>
    private let validationCodeBuilder: (([ErrorCode]) -> Content?)?
    
    init(error: ShopifyErrors<ErrorCode>,
         @ViewBuilder validationCodeBuilder: @escaping ([ErrorCode]) -> Content?) {
        self.error = error
        self.validationCodeBuilder = validationCodeBuilder
    }
    
    init(error: ShopifyErrors<ErrorCode>) {
        self.error = error
        self.validationCodeBuilder = nil
    }
    
    var body: some View {
        switch error {
            case .Cancelled:
                error(error: error)
            case .Unknown:
                error(error: error)
            case .NotFound:
                error(error: error)
            case .Unautherized:
                error(error: error)
            case .Throttled:
                error(error: error)
            case .Client(let error):
                if let error = error as? LocalErrors {
                    LocalErrorView(error: error)
                } else {
                    Text(error.localizedDescription)
                }
            case .Validation(let errors):
                let errorCodes = errors.compactMap(\.errorCode)
                if let validationCodeBuilder = validationCodeBuilder,
                   !errorCodes.isEmpty {
                    validationCodeBuilder(errorCodes)
                } else if let error = errors.first {
                    Text(error.message)
                } else {
                    Text("ShopifyErrors.Validation")
                }
            case .Generic(let errors):
                if let error = errors.first {
                    GenericErrorView(error: error)
                } else {
                    Text("ShopifyErrors.Generic")
                }
        }
    }
    
    private func error(error: ShopifyErrors<ErrorCode>) -> some View {
        Text("ShopifyErrors.\(String(describing: error))")
    }
}

struct ShopifyErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ShopifyErrorView(error: ShopifyErrors<Any>.Cancelled) { _ in
            Text("code")
        }
    }
}
