//
//  AnyKeyChain.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation

struct KeyChainResponse {
    var status: OSStatus?
    var value: Any?
}

protocol AnyKeyChain {
    
    func readAll(groupId: String?,
                 accountName: String?,
                 synchronizable: Bool?) -> KeyChainResponse
    
    func read(key: String,
              groupId: String?,
              accountName: String?,
              synchronizable: Bool?) -> KeyChainResponse
    
    func deleteAll(groupId: String?,
                   accountName: String?,
                   synchronizable: Bool?) -> OSStatus
    
    func delete(key: String,
                groupId: String?,
                accountName: String?,
                synchronizable: Bool?) -> OSStatus
    
    func write(key: String,
               value: Data,
               groupId: String?,
               accountName: String?,
               synchronizable: Bool?,
               accessibility: String?) -> OSStatus
    
    func containsKey(key: String,
                     groupId: String?,
                     accountName: String?,
                     synchronizable: Bool?) -> Bool
}

extension AnyKeyChain {
    
    func readAll() -> KeyChainResponse {
        return readAll(groupId: nil,
                       accountName: nil,
                       synchronizable: nil)
    }
    
    func read(key: String) -> KeyChainResponse {
        return read(key: key,
                    groupId: nil,
                    accountName: nil,
                    synchronizable: nil)
    }
    
    func deleteAll() -> OSStatus {
        return deleteAll(groupId: nil,
                         accountName: nil,
                         synchronizable: nil)
    }
    
    func delete(key: String) -> OSStatus {
        return delete(key: key,
                      groupId: nil,
                      accountName: nil,
                      synchronizable: nil)
    }
    
    func write(key: String, value: Data) -> OSStatus {
        return write(key: key,
                     value: value,
                     groupId: nil,
                     accountName: nil,
                     synchronizable: nil,
                     accessibility: nil)
    }
    
    func containsKey(key: String) -> Bool {
        return containsKey(key: key,
                           groupId: nil,
                           accountName: nil,
                           synchronizable: nil)
    }
}
