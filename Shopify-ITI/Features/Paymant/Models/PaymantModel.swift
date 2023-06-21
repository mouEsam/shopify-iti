//
//  PaymantModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import Foundation
import PassKit
 let MARCHANT_ID = "merchant.com.pushpendra.pay"
struct PaymantModel{
    func creatDraftOrder(productVariant:[ProductVariant])async->Result<Void,Error>{
        
        return .failure(LocalErrors.Invalid)
    }
    func completeDraftOrder(productVariant:[ProductVariant])async->Result<Void,Error>{
        
        return .failure(LocalErrors.Invalid)
    }
    func getPaymentRequest(total : Double) -> PKPaymentRequest {
        let request = PKPaymentRequest()
        request.merchantIdentifier = MARCHANT_ID
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG", "US"]
        request.merchantCapabilities = .capability3DS
        
        request.countryCode = "EG"
        request.currencyCode = "EGP"
        
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: total ))]
        return request
    }
}
