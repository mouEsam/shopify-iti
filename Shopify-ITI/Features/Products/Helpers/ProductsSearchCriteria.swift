//
//  ProductsSearchCriteria.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation

enum ProductSearchCriteria: Hashable {
    case collection
    case query
    case tag
    case vendor
    case type
}
