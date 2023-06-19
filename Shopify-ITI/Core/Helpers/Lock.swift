//
//  Lock.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

func synced<T>(_ lock: Any, closure: () -> T) -> T {
    objc_sync_enter(lock)
    let result = closure()
    objc_sync_exit(lock)
    return result
}
