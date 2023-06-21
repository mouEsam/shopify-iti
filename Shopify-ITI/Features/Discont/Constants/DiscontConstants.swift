//
//  DiscontConstants.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 20/06/2023.
//

import Foundation
struct DiscountConstants {
    
    static let constants: [AD] = [
        AD(id: 1, adImage: "AD1", adMessage: "Save $20 on your next purchase!", coupons: "SAVE20",type: .percentage,value: 20),
        AD(id: 2, adImage: "AD2", adMessage: "Get 10% off your order today!", coupons: "10OFF",type: .percentage,value: 20),
        AD(id: 3, adImage: "AD3", adMessage: "Limited time offer: Save big with our discounts!", coupons: "BIGSALE",type: .fixedAmount,value: 30),
        AD(id: 4, adImage: "AD4", adMessage: "Shop now and save 20L.E off!", coupons: "SHOP15",type: .fixedAmount,value: 20),
        AD(id: 5, adImage: "AD5", adMessage: "Flash sale: 50% off select items!", coupons: "FLASH50",type: .percentage,value: 50)
    ]
}
