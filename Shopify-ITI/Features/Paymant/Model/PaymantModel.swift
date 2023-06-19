//
//  PaymantModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 19/06/2023.
//

import Foundation
struct PaymantModel{
    func creatDraftOrder(productVariant:[ProductVariant])async->Result<Void,Error>{
        
        return .failure(LocalErrors.Invalid)
    }
    func completeDraftOrder(productVariant:[ProductVariant])async->Result<Void,Error>{
        
        return .failure(LocalErrors.Invalid)
    }
}
