//
//  AnyCartModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
protocol AnyCartModel : AnyInjectable{
    func getCart(with id:String) async ->  Result<Cart?, Error>
}
