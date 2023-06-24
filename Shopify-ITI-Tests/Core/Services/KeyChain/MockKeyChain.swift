//
//  MockKeyChain.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockKeyChain: AnyKeyChain {
    
    var keyChain: AnyKeyChain? = nil
    var readAllResult: KeyChainResponse! = nil
    var readResult: KeyChainResponse! = nil
    var deleteAllResult: OSStatus! = nil
    var deleteResult: OSStatus! = nil
    var writeResult: OSStatus! = nil
    var containsKeyResult: Bool! = nil
    
    func readAll(groupId: String?,
                 accountName: String?,
                 synchronizable: Bool?) -> KeyChainResponse {
        if let keyChain = keyChain {
            return keyChain.readAll(groupId: groupId,
                                    accountName: accountName,
                                    synchronizable: synchronizable)
        } else {
            return readAllResult
        }
    }
    
    func read(key: String,
              groupId: String?,
              accountName: String?,
              synchronizable: Bool?) -> KeyChainResponse {
        if let keyChain = keyChain {
            return keyChain.read(key:key,
                                 groupId: groupId,
                                 accountName: accountName,
                                 synchronizable: synchronizable)
        } else {
            return readResult
        }
    }
    
    func deleteAll(groupId: String?,
                   accountName: String?,
                   synchronizable: Bool?) -> OSStatus {
        if let keyChain = keyChain {
            return keyChain.deleteAll(groupId: groupId,
                                      accountName: accountName,
                                      synchronizable: synchronizable)
        } else {
            return deleteAllResult
        }
    }
    
    func delete(key: String,
                groupId: String?,
                accountName: String?,
                synchronizable: Bool?) -> OSStatus {
        if let keyChain = keyChain {
            return keyChain.delete(key:key,
                                   groupId: groupId,
                                   accountName: accountName,
                                   synchronizable: synchronizable)
        } else {
            return deleteResult
        }
    }
    
    func write(key: String,
               value: Data,
               groupId: String?,
               accountName: String?,
               synchronizable: Bool?,
               accessibility: String?) -> OSStatus {
        if let keyChain = keyChain {
            return keyChain.write(key:key,
                                  value:value,
                                  groupId: groupId,
                                  accountName: accountName,
                                  synchronizable: synchronizable,
                                  accessibility:accessibility)
        } else {
            return writeResult
        }
    }
    
    func containsKey(key: String,
                     groupId: String?,
                     accountName: String?,
                     synchronizable: Bool?) -> Bool {
        if let keyChain = keyChain {
            return keyChain.containsKey(key:key,
                                        groupId: groupId,
                                        accountName: accountName,
                                        synchronizable: synchronizable)
        } else {
            return containsKeyResult
        }
    }
}
