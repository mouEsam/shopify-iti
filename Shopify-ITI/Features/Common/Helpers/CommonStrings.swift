//
//  CommonStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation

protocol AnyCommonStrings {
    var ok: String {get}
    var cancel: String {get}
}

struct CommonStrings: AnyCommonStrings, AnyInjectable  {
    
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCommonStrings).self) { resolver in
            CommonStrings()
        }
    }
   
    let ok: String = "CommonStrings.ok"
    let cancel: String = "CommonStrings.cancel"
}
