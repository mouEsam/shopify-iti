//
//  CartStrings.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 22/06/2023.
//

import Foundation

protocol AnyCartStrings:AnyInjectable {
    var price: String { get }
    var total: String { get }
    var checkout: String { get }
    var emptyCartTitle: String { get }
    var emptyCartMessage: String { get }
    var ok: String { get }
    var loginRequiredTitle: String { get }
    var loginRequiredMessage: String { get }
    var login: String { get }
}
struct CartStrings: AnyCartStrings  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCartStrings).self) { resolver in
            CartStrings()
        }
    }
    
    let price = "CartStrings.price"
    let total = "CartStrings.total"
    let checkout = "CartStrings.checkOut"
    let emptyCartTitle = "CartStrings.emptyCartTitle"
    let emptyCartMessage = "CartStrings.emptyCartMessage"
    let ok = "CartStrings.ok"
    let loginRequiredTitle = "CartStrings.loginRequiredTitle"
    let loginRequiredMessage = "CartStrings.loginRequiredMessage"
    let login = "CartStrings.login"
    
}
