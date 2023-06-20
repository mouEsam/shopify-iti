//
//  SearchViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 20/06/2023.

//

import Foundation
class SearchViewModel:ObservableObject{
    
    @Published private(set) var items : [String] = []
    
   
    
    func addFavorite(_ item: String) {
        if(!items.contains(item)){
            items.insert(item, at: 0)
            
            saveFavorites()
        }
    }


    func saveFavorites() {
        let data = Array(items.prefix(20))
        UserDefaults.standard.set(data, forKey: "SerachList")
    }

    func retrieveFavorites() {
        if let items = UserDefaults.standard.array(forKey: "SerachList") as? [String] {
            print(items.count)
            self.items = items
        }
    }
}
