//
//  AnyCartChecker.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
protocol AnyCartChecker:AnyInjectable{
    func getCartID(for id:String?)->String?
    func set(cardID:String,with id:String?)
}
