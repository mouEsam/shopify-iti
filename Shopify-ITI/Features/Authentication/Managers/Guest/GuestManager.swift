//
//  GuestManager.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Combine

protocol AnyGuestManager: AnyInjectable {
    var state: GuestState { get }
    var statePublisher: Published<GuestState>.Publisher { get }
    func setGuest(guest: Guest, persist: Bool) -> Result<Void, LocalErrors>
    func delete()
}

class GuestManager: AnyGuestManager {
    static func register(_ container: AppContainer) {
        container.register(type: AnyGuestManager.self) { resolver in
            GuestManager(store: resolver.require((any AnyGuestLocalStore).self))
        }
    }
    
    private let store: any AnyGuestLocalStore
    
    @Published private(set) var state: GuestState = .none
    var statePublisher: Published<GuestState>.Publisher { $state }
    
    init(store: some AnyGuestLocalStore) {
        self.store = store
        self.initialize()
    }
    
    private func initialize() {
        if case .success(let guest) = store.read() {
            state = .some(guest: guest)
        }
    }
    
    func setGuest(guest: Guest, persist: Bool = true) -> Result<Void, LocalErrors> {
        if persist, case .failure(let error) = store.write(guest: guest) {
            return .failure(error)
        }
        return .success(handleGuest(guest))
    }
    
    private func handleGuest(_ guest: Guest) {
        state = .some(guest: guest)
    }
    
    func delete() {
        store.delete()
        state = .none
    }
}
