//
//  GuestLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

struct GuestLocalStore: AnyGuestLocalStore {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyGuestLocalStore).self) { resolver in
            GuestLocalStore(userDefaults: resolver.require(UserDefaults.self),
                            keysProvider: resolver.require((any AnyKeysProvider).self),
                            encoder: resolver.require((any AnyEncoder).self),
                            decoder: resolver.require((any AnyDecoder).self))
        }
    }
    
    private let userDefaults: UserDefaults
    private let keysProvider: any AnyKeysProvider
    private let encoder: any AnyEncoder
    private let decoder: any AnyDecoder
    
    func exists() -> Bool {
        return userDefaults.data(forKey: keysProvider.guestLocalKey) != nil
    }
    
    func read() -> Result<Guest, LocalErrors> {
        if let data = userDefaults.data(forKey: keysProvider.guestLocalKey) {
            do {
                let guest = try decoder.decode(target: Guest.self, data: data)
                return .success(guest)
            } catch {
                return .failure(LocalErrors.Invalid)
            }
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func write(guest: Guest) -> Result<Void, LocalErrors> {
        do {
            let data = try encoder.encode(object: guest)
            return .success(userDefaults.set(data, forKey: keysProvider.guestLocalKey))
        } catch {
            return .failure(.Invalid)
        }
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.guestLocalKey)
    }
}
