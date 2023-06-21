//
//  CategoriesStrings.swift
//  Shopify-ITI
//
//  Created by ammar on 18/06/2023.
//

import Foundation

protocol AnyCategoriesStrings {
    var menLabel: String { get }
    var womenLabel: String { get }
    var kidLabel: String { get }
    var saleLabel: String { get }
  
}
// TODO: localize
struct CategoriesStrings: AnyCategoriesStrings, AnyInjectable  {
  
    
    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCategoriesStrings).self) { resolver in
            CategoriesStrings()
        }
    }
    var menLabel: String = "men"
    
    var womenLabel: String = "women"
    
    var kidLabel: String = "kid"
    
    var saleLabel: String = "sale"
    
}
