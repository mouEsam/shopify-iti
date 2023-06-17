//
//  CategoriesViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
class CategoriesViewModel : ObservableObject {
    @Published private(set) var operationState: UIState<[ProductType]> = .initial
    
  
    private let model: AnyCategoriesModel
    
    init( model: AnyCategoriesModel) {
        self.model = model
    }
    
    func loadCategories(CollectionName name : String) async{
        await MainActor.run(){
            self.operationState = .loading
        }
        let res =  await model.fetch(CollectionName:name).toRemote()
        
        await MainActor.run(){
            self.operationState = res
        }

    }
}
