//
//  UserLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

struct UserLocalStore: AnyUserLocalStore {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyUserLocalStore).self) { resolver in
            UserLocalStore(userDefaults: resolver.require(UserDefaults.self),
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
        return userDefaults.data(forKey: keysProvider.userLocalKey) != nil
    }
    
    func read() -> Result<User, LocalErrors> {
        if let data = userDefaults.data(forKey: keysProvider.userLocalKey) {
            do {
                let user = try decoder.decode(target: User.self, data: data)
                return .success(user)
            } catch {
                return .failure(LocalErrors.Invalid)
            }
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func write(user: User) -> Result<Void, LocalErrors> {
        do {
            let data = try encoder.encode(object: user)
            return .success(userDefaults.set(data, forKey: keysProvider.userLocalKey))
        } catch {
            return .failure(.Invalid)
        }
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.userLocalKey)
    }
}
