//
//  AuthenticationState.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated(user: User, token: AccessToken)
    case guest(guest: Guest)
}

extension AuthenticationState {
    var user: User? {
        if case let .authenticated(user, _) = self {
            return user
        }
        return nil
    }
    
    var guest: Guest? {
        if case let .guest(guest) = self {
            return guest
        }
        return nil
    }
}
