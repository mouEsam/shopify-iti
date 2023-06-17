//
//  ProfileRepository.swift
//  Shopify-ITI
//
//  Created by ammar on 17/06/2023.
//

import Foundation
struct ProfileRepository : AnyProfileRepository {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyProfileRepository).self) { resolver in
            ProfileRepository(profileService: resolver.require(ProfileRemoteService.self), wishlistManager: resolver.require(WishlistManager.self))
        }
    }
    private let profileService: ProfileRemoteService
    private let wishlistManager: WishlistManager
    
    init(profileService: ProfileRemoteService, wishlistManager: WishlistManager) {
        self.profileService = profileService
        self.wishlistManager = wishlistManager
    }
    
    func profile() async -> Result<User, ProfileError> {
        return await profileService.profile()
    }
    
 
    
    func getOrders() async -> Result<Any, Error> {
        return .success([])//TODO: get orders
    }
    
   
    
    
    
    
    
    
}
