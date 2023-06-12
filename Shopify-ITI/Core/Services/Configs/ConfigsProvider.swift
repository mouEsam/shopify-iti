//
//  ConfigsProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation

struct ConfigsProvider: AnyConfigsProvider {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyConfigsProvider).self) { resolver in
            ConfigsProvider()
        }
    }
    
    let collectionsCountInProductInfoPage: Int = 10
    let variantsCountInProductInfoPage: Int = 10
    let imagesCountInProductInfoPage: Int = 10
    let productsCountPerPage: Int = 10
}
