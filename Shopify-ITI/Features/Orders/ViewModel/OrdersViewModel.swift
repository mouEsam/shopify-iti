//
//  OrdersViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation
import Combine

class OrdersViewModel : ObservableObject{
    
    @Published private(set) var operationState: UIState<[Order]> = .initial
    
    private let model: AnyOrdersModel
    
    init( model: AnyOrdersModel) {
        self.model = model
    }
    
    func loadBrand() async{
        await MainActor.run(){
            self.operationState = .loading
        }
        
        let res =  await model.fetch().toRemote()
        
        await MainActor.run(){
            self.operationState = res
            
        }

    }
   
    
    
}
