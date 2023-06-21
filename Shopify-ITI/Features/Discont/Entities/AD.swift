//
//  AD.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 10/06/2023.
//

import Foundation
struct AD:Identifiable{
    let id:Int
    let adImage:String
    let adMessage:String
    let coupons:String
    let type:couponsType
    let value:Double

}
enum couponsType:String{
    case fixedAmount = "FIXED_AMOUNT"
    case percentage = "PERCENTAGE"
}
