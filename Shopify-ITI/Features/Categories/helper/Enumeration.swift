//
//  enum.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
import SwiftUI


enum CollectionType: String {
    case men
    case women
    case kid
    case sale
    
    var apiHandle: String { rawValue }
    
    var apiID: String {
        switch(self){
        case .men:
            return "gid://shopify/Collection/446669947159"
        case .women :
            return "gid://shopify/Collection/446670045463"
        case .kid :
            return "gid://shopify/Collection/446670110999"
        default:
            return "gid://shopify/Collection/446670176535"
        }
    }
    func localizedString(using localizationService: AnyCategoriesStrings) -> LocalizedStringKey {
        switch(self){
        case .men:
            return localizationService.menLabel.localized
        case .women :
            return localizationService.womenLabel.localized
        case .kid :
            return localizationService.kidLabel.localized
        default:
            return localizationService.saleLabel.localized
        }
          
      }
        
}

