//
//  Notifications.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation

struct RenewedSessionNotification: AppNotification {
    static let rawName: String = "RenewedSessionNotification"
}

struct EndSessionNotification: AppNotification {
    static let rawName: String = "EndSessionNotification"
}
