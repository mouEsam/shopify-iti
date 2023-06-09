//
//  AnyConfigsProvider.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import Foundation

protocol AnyConfigsProvider {
    var collectionsCountInProductInfoPage: Int { get }
    var variantsCountInProductInfoPage: Int { get }
    var imagesCountInProductInfoPage: Int { get }
    var productsCountPerPage: Int { get }
}
