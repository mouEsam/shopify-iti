//
//  ApplePaymentSheet.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import Foundation
import PassKit
import SwiftUI
struct ApplePaymentSheet: UIViewControllerRepresentable {
    @Binding var showingPaymentSheet: Bool

    func makeUIViewController(context: Context) -> PKPaymentAuthorizationViewController {
        let request = PKPaymentRequest()
        request.merchantIdentifier = MARCHANT_ID
        request.supportedNetworks = [.quicPay, .masterCard, .visa]
        request.supportedCountries = ["EG", "US"]
        request.merchantCapabilities = .capability3DS
        
        request.countryCode = "EG"
        request.currencyCode = "EGP"
        
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Shopify", amount: NSDecimalNumber(value: 5.5 ))]

        let paymentController = PKPaymentAuthorizationViewController(paymentRequest: request)
        paymentController?.delegate = context.coordinator
        return paymentController!
    }
    
    func updateUIViewController(_ uiViewController: PKPaymentAuthorizationViewController, context: Context) {
        if !showingPaymentSheet {
            uiViewController.dismiss(animated: true, completion: nil)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
        var parent: ApplePaymentSheet

        init(_ parent: ApplePaymentSheet) {
            self.parent = parent
        }

        func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
            parent.showingPaymentSheet = false
        }
    }
}
