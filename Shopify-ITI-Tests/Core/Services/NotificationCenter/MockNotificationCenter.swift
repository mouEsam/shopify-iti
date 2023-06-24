//
//  MockNotificationCenter.swift
//  Shopify-ITI-Tests
//
//  Created by Mostafa Ibrahim on 24/06/2023.
//

import Foundation
@testable import Shopify_ITI

class MockNotificationCenter: AnyNotificationCenter {
    
    var center: AnyNotificationCenter? = nil
    var publisherResult: NotificationCenter.Publisher! = nil
    
    func post(_ notification: Notification) {
        if let center = center {
            center.post(notification)
        }
    }
    
    func publisher(for name: Notification.Name, object: AnyObject?) -> NotificationCenter.Publisher {
        if let center = center {
            return center.publisher(for: name, object: object)
        } else {
            return publisherResult
        }
    }
}
