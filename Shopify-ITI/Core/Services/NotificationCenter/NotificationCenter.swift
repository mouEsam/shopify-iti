//
//  NotificationCenter.swift
//  BallPark
//
//  Created by Mostafa Ibrahim on 04/06/2023.
//

import Foundation

extension NotificationCenter: AnyNotificationCenter {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyNotificationCenter).self) { resolver in
            NotificationCenter.default
        }
    }
}
