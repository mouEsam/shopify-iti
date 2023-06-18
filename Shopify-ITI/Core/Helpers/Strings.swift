//
//  Strings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation

extension String {
    var localized: String { NSLocalizedString(self, comment: self) }
}
