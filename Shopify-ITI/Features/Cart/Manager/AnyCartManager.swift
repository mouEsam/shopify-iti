//
//  AnyCartManager.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
protocol AnyCartManager:AnyInjectable{
    func createOrUpdateCart(withVariant id:String,quantity :Int)async->Result<Cart?, Error>
}
