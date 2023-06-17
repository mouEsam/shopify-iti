//
//  AnyCartModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 13/06/2023.
//

import Foundation
protocol AnyCartModel : AnyInjectable{
    func getCart(with id:String) async ->  Result<Cart, Error>
    func changeItemQuantity(forCart id: String,forLine lineId:String,with quantity:Int ) async -> Result<Cart, Error>
    func deleteCartItem(forCart id: String,forLine lineId:String) async -> Result<Cart, Error>
}
