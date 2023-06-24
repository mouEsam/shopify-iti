//
//  PaymentStrings.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import Foundation
protocol AnyPaymentStrings:AnyInjectable{
    var shippingAddressHeader: String { get }
    var placeholderName: String { get }
    var paymentMethodLabel: String { get }
    var cashOnDelivery: String { get }
    var applePay: String { get }
    var discountCouponLabel: String { get }
    var addCouponLabel: String { get }
    var priceLabel: String { get }
    var subTotalLabel: String { get }
    var taxLabel: String { get }
    var discountLabel: String { get }
    var totalLabel: String { get }
    var proceedToPaymentButton: String { get }
    var totalAmountLabel: String { get }
    var payButton: String { get }
    var cancelButton: String { get }
    var doneButton: String { get }
}

struct PaymentStrings: AnyPaymentStrings {
    static func register(_ container: AppContainer) {
        container.register(type: PaymentStrings.self){ _ in
            PaymentStrings()
        }
    }
    
    let shippingAddressHeader = "PaymentStrings.shippingAddress"
    let placeholderName = "PaymentStrings.placeHolderName"
    let paymentMethodLabel = "PaymentStrings.paymentMethod"
    let cashOnDelivery = "PaymentStrings.cashOnDelivery"
    let applePay = "PaymentStrings.applepay"
    let discountCouponLabel = "PaymentStrings.discountCoupon"
    let addCouponLabel = "PaymentStrings.addCoupon"
    let priceLabel = "PaymentStrings.price"
    let subTotalLabel = "PaymentStrings.subTotal"
    let taxLabel = "PaymentStrings.tax"
    let discountLabel = "PaymentStrings.discount"

    let totalLabel = "PaymentStrings.total"
    let proceedToPaymentButton = "PaymentStrings.proceedToPayment"
    let totalAmountLabel = "PaymentStrings.totalAmount"
    let payButton = "PaymentStrings.pay"
    let cancelButton = "PaymentStrings.cancel"
    let doneButton = "PaymentStrings.done"
}
