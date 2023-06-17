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
            ProfileRepository(profileService: resolver.require(ProfileRemoteService.self), wishlistRemoteService: resolver.require(WishlistRemoteService.self))
        }
    }
    private let profileService: ProfileRemoteService
    private let wishlistRemoteService: WishlistRemoteService
    
    init(profileService: ProfileRemoteService, wishlistRemoteService: WishlistRemoteService) {
        self.profileService = profileService
        self.wishlistRemoteService = wishlistRemoteService
    }
    
    func profile() async -> Result<User, ProfileError> {
        return await profileService.profile()
    }
    
    func getWishList() async -> Result<Wishlist, WishlistError> {
        return await wishlistRemoteService.fetch()
    }
    
    func getOrders() async -> Result<Any, Error> {
        return .success([])//TODO: get orders
    }
    
   
    
    
    
    
    
    
}
