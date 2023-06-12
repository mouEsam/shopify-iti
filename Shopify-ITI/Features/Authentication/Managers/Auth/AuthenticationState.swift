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
