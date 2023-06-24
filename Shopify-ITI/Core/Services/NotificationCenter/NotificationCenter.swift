//
//  NotificationCenter.swift
//  BallPark
//
//  Created by Mostafa Ibrahim on 04/06/2023.
//

import Foundation

extension NotificationCenter: AnyNotificationCenter, AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: NotificationCenter.self) { resolver in
            NotificationCenter.default
        }.implements((any AnyNotificationCenter).self)
    }
}
