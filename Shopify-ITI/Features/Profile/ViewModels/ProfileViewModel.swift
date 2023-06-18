//
//  ProfileViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 17/06/2023.
//

import Foundation
import SwiftUI
 //TODO: refactor
class ProfileViewModel : ObservableObject{

    let authenticationManager:AuthenticationManager
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
        
    }
    func getName()->String?{
        authenticationManager.refreshState()
        
        return authenticationManager.state.user?.firstName
        
    }
    

    
}
