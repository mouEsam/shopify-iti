//
//  PaymentHandler.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {

static let supportedNetworks: [PKPaymentNetwork] = [
    .amex,
    .masterCard,
    .visa
]

var paymentController: PKPaymentAuthorizationController?
var paymentStatus = PKPaymentAuthorizationStatus.failure
var completionHandler: PaymentCompletionHandler?

func startPayment(completion: @escaping PaymentCompletionHandler) {

    completionHandler = completion

    // Create our payment request
    let request = PKPaymentRequest()
    request.merchantIdentifier = MARCHANT_ID
    request.supportedNetworks = [.quicPay, .masterCard, .visa]
    request.supportedCountries = ["EG", "US"]
    request.merchantCapabilities = .capability3DS
    
    request.countryCode = "EG"
    request.currencyCode = "EGP"
    
    request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: 5.5 ))]


    // Display our payment request
    paymentController = PKPaymentAuthorizationController(paymentRequest: request)
    paymentController?.delegate = self
    paymentController?.present(completion: { (presented: Bool) in
        if presented {
            NSLog("Presented payment controller")
        } else {
            NSLog("Failed to present payment controller")
            self.completionHandler!(false)
         }
     })
  }
}

/*
    PKPaymentAuthorizationControllerDelegate conformance.
*/
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {

func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {

    // Perform some very basic validation on the provided contact information
    paymentStatus = .success

    completion(paymentStatus)
}

func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
    controller.dismiss {
        DispatchQueue.main.async {
            if self.paymentStatus == .success {
                self.completionHandler!(true)
            } else {
                self.completionHandler!(false)
            }
        }
    }
}

}
