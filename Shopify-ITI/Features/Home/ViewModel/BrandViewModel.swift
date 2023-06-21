//
//  BrandViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 13/06/2023.
//

import Foundation
import Combine

class BrandViewModel : ObservableObject{
    
    @Published private(set) var operationState: UIState<[ProductCollection]> = .initial
    
    private let model: AnyBrandModel
    
    init( model: AnyBrandModel) {
        self.model = model
 
        
    }
    
    func loadBrand(numberOfItem count : Int) async{
            // Your code to be executed on the main thread
        await MainActor.run(){
            self.operationState = .loading
        }
        let res =  await model.fetch(numberOfItem: count).toRemote()
        
        await MainActor.run(){
            self.operationState = res
        }

    }
   
    
    
}
