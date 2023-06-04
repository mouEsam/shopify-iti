//
//  Notifications.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 05/06/2023.
//

import Foundation

protocol AppNotification {
    static var rawName: String { get }
}

extension AppNotification {
    static var name: Notification.Name { Notification.Name(Self.rawName) }
    
    func toNotification() -> Notification {
        return Notification(name: Self.name, object: self)
    }
    
    func post(_ center: some AnyNotificationCenter) {
        center.post(toNotification())
    }
}

extension AnyNotificationCenter {
    func post(_ notification: some AppNotification) {
        post(notification.toNotification())
    }
}
