//
//  HomeStrings.swift
//  Shopify-ITI
//
//  Created by ammar on 18/06/2023.
//

import Foundation


protocol AnyHomeStrings {
    var brandsLabel: String { get }
  
}
// TODO: localize
struct HomeStrings: AnyHomeStrings, AnyInjectable  {
    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyHomeStrings).self) { resolver in
            HomeStrings()
        }
    }
   
    var brandsLabel: String = "Brands"
    
}
