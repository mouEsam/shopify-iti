//
//  ProfileViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 17/06/2023.
//

import Foundation
 //TODO: refactor
class  ProfleViewModel : ObservableObject{
    
    private let repository: any AnyProfileRepository
    
    init(repository: any AnyProfileRepository) {
        self.repository = repository
    }
    @Published private(set) var userOperationState: UIState<User> = .initial
    @Published private(set) var wishListOperationState: UIState<Wishlist> = .initial

    func profile() async {
        await MainActor.run(){
            self.userOperationState = .loading
        }
        let res =  await repository.profile().toRemote()
        
        await MainActor.run(){
            self.userOperationState = res
        }
    }
    
   
    func getOrders() async {
        
    }

    
}
