//
//  Lock.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation
import Semaphore

func synced<T>(_ lock: Any, closure: () -> T) -> T {
    objc_sync_enter(lock)
    let result = closure()
    objc_sync_exit(lock)
    return result
}

extension AsyncSemaphore {
    func with<Result>(criticalSection: () async -> Result) async -> Result {
        await self.wait()
        defer { self.signal() }
        return await criticalSection()
    }
    
    func withUnlessCancelled<Result>(criticalSection: () async -> Result) async throws -> Result {
        try await self.waitUnlessCancelled()
        defer { self.signal() }
        return await criticalSection()
    }
}
