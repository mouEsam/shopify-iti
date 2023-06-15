//
//  ListableProduct.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 16/06/2023.
//

import Foundation

struct ListableProduct: Identifiable {
    var id: String { product.id }
    
    let product: Product
    let isWishlisted: Bool
    
    init(product: Product, isWishlisted: Bool) {
        self.product = product
        self.isWishlisted = isWishlisted
    }
    
    func copyWith(product: Product? = nil,
                  isWishlisted: Bool? = nil) -> ListableProduct {
        return .init(product: product ?? self.product,
                     isWishlisted: isWishlisted ?? self.isWishlisted)
    }
}

extension ListableProduct {
    init(product: Product) {
        self.product = product
        self.isWishlisted = false
    }
}
