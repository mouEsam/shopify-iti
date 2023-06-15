//
//  CartChecker.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
struct CartChecker:AnyCartChecker{
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyCartChecker).self) { resolver in
            CartChecker()
        }
    }
    
    func getCartID(for id:String?)->String?{
        guard let id = id else {
            return UserDefaults.standard.string(forKey: "DefaultCart")
        }
            
        if let cartDictionary = UserDefaults.standard.dictionary(forKey: "Cart"){
            return   cartDictionary[id] as? String
        }
        return nil
    }
    func set(cardID:String,with id:String?){
        guard let id = id else{
            UserDefaults.standard.set(cardID, forKey: "DefaultCart")
            return
        }
        var cartDictionary = UserDefaults.standard.dictionary(forKey: "Cart") as? [String: String] ?? [:]
        cartDictionary[id] = cardID
        UserDefaults.standard.set(cartDictionary, forKey: "Cart")
    }
    
}
