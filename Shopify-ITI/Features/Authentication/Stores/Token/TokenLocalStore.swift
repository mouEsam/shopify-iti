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
            TokenLocalStore(keyChain: resolver.require((any AnyKeyChain).self),
                            keysProvider: resolver.require((any AnyKeysProvider).self),
                            encoder: resolver.require((any AnyEncoder).self),
                            decoder: resolver.require((any AnyDecoder).self))
        }
    }
    
    private let keyChain: any AnyKeyChain
    private let keysProvider: any AnyKeysProvider
    private let encoder: any AnyEncoder
    private let decoder: any AnyDecoder
    
    func exists() -> Bool {
        return keyChain.containsKey(key: keysProvider.accessTokenLocalKey,
                                    groupId: nil,
                                    accountName: nil,
                                    synchronizable: nil)
    }
    
    func read() -> Result<AccessToken, LocalErrors> {
        if let data = keyChain.read(key: keysProvider.accessTokenLocalKey).value as? Data {
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
            let res = keyChain.write(key: keysProvider.accessTokenLocalKey, value: data)
            guard res != noErr else { return .success(Void()) }
            print(res)
            return .failure(.Unknown)
        } catch {
            return .failure(.Invalid)
        }
    }
    
    func delete() {
        _ = keyChain.delete(key: keysProvider.accessTokenLocalKey)
    }
}
