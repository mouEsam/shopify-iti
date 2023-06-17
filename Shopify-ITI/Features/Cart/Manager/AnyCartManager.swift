//
//  AnyCartManager.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
protocol AnyCartManager:AnyInjectable{
    func addItem(productVariant item: ProductVariant,quantity :Int) async -> Result<Cart, Error>
    
}
