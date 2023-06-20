//
//  AnySettingModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation

protocol AnySettingModel : AnyInjectable{
    
    func fetch() async -> Result<SourcedData<Localization>, ShopifyErrors<Any>>
    func changelanguage(language:Language)
    func changeCurrency(currency:Country)
    
}
