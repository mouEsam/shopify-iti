//
//  LocalErrorText.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import SwiftUI

extension LocalErrors {
    var text: Text {
        Text("LocalErrors.\(rawValue)".localized)
    }
}
