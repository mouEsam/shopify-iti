//
//  Strings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI
import LanguageManagerSwiftUI

extension String {
    var localized: LocalizedStringKey {
        return self.localizedKey
    }
}
