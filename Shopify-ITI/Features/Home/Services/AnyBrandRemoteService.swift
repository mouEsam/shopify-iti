//
//  AnyBrandRemoteService.swift
//  Shopify-ITI
//
//  Created by ammar on 14/06/2023.
//

import Foundation
protocol AnyBrandRemoteService {
    func fetch(count : Int) async -> Result<[ProductCollection], Error> 
}
