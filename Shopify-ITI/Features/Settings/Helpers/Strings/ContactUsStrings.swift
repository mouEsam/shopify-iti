//
//  ContactUsStrings.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 22/06/2023.
//

import Foundation
protocol AnyContactUsStrings: AnyInjectable {
    var contactInformation: String { get }
    var email: String { get }
    var phone: String { get }
    var address: String { get }
    var contactUs: String { get }
    var navigationTitle: String { get }
}

struct ContactUsStrings: AnyContactUsStrings {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyContactUsStrings).self) { _ in
            ContactUsStrings()
        }
    }
    
    var contactInformation: String = "ContactUsStrings.contactInformation"
    
    var email: String = "ContactUsStrings.email"
    
    
    var phone: String = "ContactUsStrings.phone"
    
    
    var address: String = "ContactUsStrings.address"
    
    
    var contactUs: String = "ContactUsStrings.contactUs"
    
    
    var navigationTitle: String = "ContactUsStrings.navigationTitle"
}
