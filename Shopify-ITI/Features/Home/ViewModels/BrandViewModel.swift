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
    private var subscribers: [AnyCancellable] = []
    
    private let model: BrandModel
    
    init( model: BrandModel) {
        self.model = model
 
        
    }
    
    func loadBrand(numberOfItem count : Int) async{
            // Your code to be executed on the main thread
        DispatchQueue.main.async {
            self.operationState = .loading
            
        }
        let res = await model.fatch(numberOfItem: count).toRemote()
        DispatchQueue.main.async {
            self.operationState = res
            
        }
       
    }
   
    
    
}
