//
//  MockAuthenticationManager.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockAuthenticationManager: AnyAuthenticationManager {
    
    var manager: AnyAuthenticationManager? = nil
    
    var statePublisherResult: PostPublished<AuthenticationState>.Publisher! = nil
    var stateResult: AuthenticationState! = nil
    var setUserResult: Result<Session, LocalErrors>! = nil
    var setGuestResult: Result<Guest, LocalErrors>! = nil
    var logoutResult: Task<(), Never>! = nil
    
    var statePublisher: PostPublished<AuthenticationState>.Publisher {
        if let manager = manager {
            return manager.statePublisher
        } else {
            return statePublisherResult
        }
    }
    
    var state: AuthenticationState {
        if let manager = manager {
            return manager.state
        } else {
            return stateResult
        }
    }
    
    func refreshState() {
        if let manager = manager {
            return manager.refreshState()
        }
    }
    
    func setUser(user: User, token: AccessToken, persist: Bool) async -> Result<Session, LocalErrors> {
        if let manager = manager {
            return await manager.setUser(user: user, token: token, persist: persist)
        } else {
            return setUserResult
        }
    }
    
    func setGuest(guest: Guest, persist: Bool) async -> Result<Guest, LocalErrors> {
        if let manager = manager {
            return await manager.setGuest(guest: guest, persist: persist)
        } else {
            return setGuestResult
        }
    }
    
    func logout() -> Task<(), Never> {
        if let manager = manager {
            return manager.logout()
        } else {
            return logoutResult
        }
    }
    
    func delete() {
        if let manager = manager {
            return manager.delete()
        }
    }
}
