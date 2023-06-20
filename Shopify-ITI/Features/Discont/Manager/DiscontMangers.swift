//
//  DiscontMangers.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 20/06/2023.
//

import Foundation
import Shopify_Admin_ITI_SDK
struct DiscountManager:AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: DiscountManager.self){ _ in
            DiscountManager()
        }
    }
    
    
     func createDiscountInput(using constant: String) ->ShopifyAdminAPI.DraftOrderAppliedDiscountInput? {
        guard let discount = DiscountConstants.constants.first(where: { $0.coupons == constant }) else {
            return nil
        }
        
        let discountType: ShopifyAdminAPI.DraftOrderAppliedDiscountType
        
        // Determine the discount type based on the constant
        switch discount.type{
            
        case .fixedAmount:
            discountType = .fixedAmount
        case .percentage:
            discountType = .percentage

        }
        return ShopifyAdminAPI.DraftOrderAppliedDiscountInput(
            amount: nil,
            description: nil,
            title: nil,
            value: discount.value,
            valueType: .init(rawValue: discountType.rawValue)
        )
    }
    
    
}
