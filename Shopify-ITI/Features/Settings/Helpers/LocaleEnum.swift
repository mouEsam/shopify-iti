//
//  LocalEnum.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 18/06/2023.
//

import Foundation
enum Language: String {
    case english = "EN"
    case arabic = "AR"
    var phonelocal: String {
        switch self {
        case .english:
            return "en"
        case .arabic:
            return "ar"
            
        }
    }
}
enum Country: String {
    case usa = "US"
    case egypt = "EG"
    
}
