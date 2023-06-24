//
//  MockProfileRemoteService.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockProfileRemoteService: AnyProfileRemoteService {
    
    var service: AnyProfileRemoteService? = nil
    
    var profileResult: Result<User, ProfileError>! = nil
    var profileForResult: Result<User, ProfileError>! = nil
    var updateResult: Result<Session, ProfileError>! = nil
    
    func profile() async -> Result<User, ProfileError> {
        if let service = service {
            return await service.profile()
        } else {
            return profileResult
        }
    }
    
    func profile(for accessToken: String) async -> Result<User, ProfileError> {
        if let service = service {
            return await service.profile(for: accessToken)
        } else {
            return profileForResult
        }
    }
    
    func update(with newProfile: ProfileUpdate) async -> Result<Session, ProfileError> {
        if let service = service {
            return await service.update(with: newProfile)
        } else {
            return updateResult
        }
    }
}
