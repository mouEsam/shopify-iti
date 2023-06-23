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
    let menLabel: String = "CategoriesStrings.menLabel"
    
    let womenLabel: String = "CategoriesStrings.womenLabel"
    
    let kidLabel: String = "CategoriesStrings.kidLabel"
    
    let saleLabel: String = "CategoriesStrings.saleLabel"
    
}
