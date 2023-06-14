//
//  BrandModel.swift
//  Shopify-ITI
//
//  Created by ammar on 14/06/2023.
//

import Foundation
class BrandModel{
    
    private let remoteService: any AnyBrandRemoteService //TODO Inject
    
    init(remoteService: any AnyBrandRemoteService) {
        self.remoteService = remoteService
    }
    func fatch(numberOfItem count:Int) async ->Result<[ProductCollection], Error> {
       
        let x = await remoteService.fetch(count: count)
        switch(x) {
        case .success(var data) :
            return .success(removeFirstItme(items: &data))
        case .failure(let erorr):
                return .failure(erorr)
        }
  
    }
    
    func removeFirstItme(items arr: inout [ProductCollection]) -> [ProductCollection]{
        if(!arr.isEmpty){
            arr.remove(at: 0)
        }
        return arr
    }
}

