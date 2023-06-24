//
//  KeyChain.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation

struct KeyChain: AnyKeyChain, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyKeyChain).self) { resolver in
            KeyChain()
        }
    }
    
    func readAll(groupId: String?,
                      accountName: String?,
                      synchronizable: Bool?) -> KeyChainResponse {
        var keychainQuery = baseQuery(key: nil, groupId: groupId, accountName: accountName, synchronizable: synchronizable, returnData: true)
        
        keychainQuery[kSecMatchLimit] = kSecMatchLimitAll
        keychainQuery[kSecReturnAttributes] = true
        
        var ref: AnyObject?
        let status = SecItemCopyMatching(
            keychainQuery as CFDictionary,
            &ref
        )
        
        var results: [String: String] = [:]
        
        if (status == noErr) {
            (ref as! NSArray).forEach { item in
                let key: String = (item as! NSDictionary)[kSecAttrAccount] as! String
                let value: String = String(data: (item as! NSDictionary)[kSecValueData] as! Data, encoding: .utf8) ?? ""
                results[key] = value
            }
        }
        
        return KeyChainResponse(status: status, value: results)
    }
    
    func read(key: String, groupId: String?, accountName: String?, synchronizable: Bool?) -> KeyChainResponse {
        let keychainQuery = baseQuery(key: key, groupId: groupId, accountName: accountName, synchronizable: synchronizable, returnData: true)
        var ref: AnyObject?
        let status = SecItemCopyMatching(
            keychainQuery as CFDictionary,
            &ref
        )
        return KeyChainResponse(status: status, value: ref as? Data)
    }
    
    func deleteAll(groupId: String?, accountName: String?, synchronizable: Bool?) -> OSStatus {
        let keychainQuery = baseQuery(key: nil, groupId: groupId, accountName: accountName, synchronizable: synchronizable, returnData: nil)
        
        return SecItemDelete(keychainQuery as CFDictionary)
    }
    
    func delete(key: String, groupId: String?, accountName: String?, synchronizable: Bool?) -> OSStatus {
        let keychainQuery = baseQuery(key: key, groupId: groupId, accountName: accountName, synchronizable: synchronizable, returnData: true)
        
        return SecItemDelete(keychainQuery as CFDictionary)
    }
    
    func write(key: String, value: Data, groupId: String?, accountName: String?, synchronizable: Bool?, accessibility: String?) -> OSStatus {
        var attrAccessible: CFString = kSecAttrAccessibleWhenUnlocked
        if (accessibility != nil) {
            switch accessibility {
            case "passcode":
                attrAccessible = kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
                break;
            case "unlocked":
                attrAccessible = kSecAttrAccessibleWhenUnlocked
                break
            case "unlocked_this_device":
                attrAccessible = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
                break
            case "first_unlock":
                attrAccessible = kSecAttrAccessibleAfterFirstUnlock
                break
            case "first_unlock_this_device":
                attrAccessible = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
                break
            default:
                attrAccessible = kSecAttrAccessibleWhenUnlocked
            }
        }
        
        let keyExists = containsKey(key: key, groupId: groupId, accountName: accountName, synchronizable: synchronizable)
        var keychainQuery = baseQuery(key: key, groupId: groupId, accountName: accountName, synchronizable: synchronizable, returnData: nil)
        if (keyExists) {
            var update: [CFString: Any?] = [
                kSecValueData: value,
                kSecAttrAccessible: attrAccessible
            ]
            if synchronizable != nil {
                update[kSecAttrSynchronizable] = synchronizable
            }
            return SecItemUpdate(keychainQuery as CFDictionary, update as CFDictionary)
        } else {
            keychainQuery[kSecValueData] = value
            keychainQuery[kSecAttrAccessible] = attrAccessible
            
            return SecItemAdd(keychainQuery as CFDictionary, nil)
        }
    }
    
    private func baseQuery(key: String?,
                           groupId: String?,
                           accountName: String?,
                           synchronizable: Bool?,
                           returnData: Bool?) -> Dictionary<CFString, Any> {
        var keychainQuery: [CFString: Any] = [kSecClass : kSecClassGenericPassword]
        if (key != nil) {
            keychainQuery[kSecAttrAccount] = key
            
        }
        
        if (groupId != nil) {
            keychainQuery[kSecAttrAccessGroup] = groupId
        }
        
        if (accountName != nil) {
            keychainQuery[kSecAttrService] = accountName
        }
        
        if (synchronizable != nil) {
            keychainQuery[kSecAttrSynchronizable] = synchronizable
        }
        
        if (returnData != nil) {
            keychainQuery[kSecReturnData] = returnData
        }
        return keychainQuery
    }
    
    func containsKey(key: String,
                              groupId: String?,
                              accountName: String?,
                              synchronizable: Bool?) -> Bool {
        if read(key: key, groupId: groupId, accountName: accountName, synchronizable: synchronizable).value != nil {
            return true
        } else {
            return false
        }
    }
}

