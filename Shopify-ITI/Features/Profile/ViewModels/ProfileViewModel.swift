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

    @Published private(set) var userState: Optional<User> = .none
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
    
    func initialize() {
        authenticationManager.$state
            .prepend(authenticationManager.state)
            .map(\.user)
            .assign(to: &$userState)
    }
    
}
