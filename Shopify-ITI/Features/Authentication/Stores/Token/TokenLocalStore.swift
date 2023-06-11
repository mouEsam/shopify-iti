//
//  TokenLocalStore.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

struct TokenLocalStore: AnyTokenLocalStore {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyTokenLocalStore).self) { resolver in
            TokenLocalStore(userDefaults: resolver.require(UserDefaults.self),
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
        return userDefaults.data(forKey: keysProvider.accessTokenLocalKey) != nil
    }
    
    func read() -> Result<AccessToken, LocalErrors> {
        if let data = userDefaults.data(forKey: keysProvider.accessTokenLocalKey) {
            do {
                let token = try decoder.decode(target: AccessToken.self, data: data)
                return .success(token)
            } catch {
                return .failure(LocalErrors.Invalid)
            }
        }
        return .failure(LocalErrors.NotFound)
    }
    
    func write(token: AccessToken) -> Result<Void, LocalErrors> {
        do {
            let data = try encoder.encode(object: token)
            return .success(userDefaults.set(data, forKey: keysProvider.accessTokenLocalKey))
        } catch {
            return .failure(.Invalid)
        }
    }
    
    func delete() {
        userDefaults.removeObject(forKey: keysProvider.accessTokenLocalKey)
    }
}
