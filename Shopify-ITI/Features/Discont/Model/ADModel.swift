//
//  ADModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 10/06/2023.
//

import Foundation
struct ADModel{
  static func getAds() -> [AD] {
        return [
            AD(id:1,adImage: "AD1", adMessage: "Save $20 on your next purchase!", coupons: "SAVE20"),
            AD(id:2,adImage: "AD2", adMessage: "Get 10% off your order today!", coupons: "10OFF"),
            AD(id:3,adImage: "AD3", adMessage: "Limited time offer: Save big with our discounts!", coupons: "BIGSALE"),
            AD(id:4,adImage: "AD4", adMessage: "Shop now and save 15% off!", coupons: "SHOP15"),
            AD(id:5,adImage: "AD5", adMessage: "Flash sale: 50% off select items!", coupons: "FLASH50")
        ]
    }
}
