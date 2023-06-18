//
//  LocalNotification.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 18/06/2023.
//

import Foundation
struct LanguageChangeNotification: AppNotification {
    static let rawName: String = "LanguageChangeNotification"
    
    let language: String
}
struct CurrencyChangeNotification: AppNotification {
    static let rawName: String = "LanguageChangeNotification"
    
    let currency: String
}
