//
//  SearchStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation

protocol AnySearchStrings {
    var searchHint: String {get}
}

struct SearchStrings: AnySearchStrings, AnyInjectable  {
    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnySearchStrings).self) { resolver in
            SearchStrings()
        }
    }
   
    let searchHint: String = "SearchStrings.searchHint"
}
