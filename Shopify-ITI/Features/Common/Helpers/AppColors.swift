//
//  AuthenticationColors.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

protocol AnyAppColors {
    var white: Color { get }
    var offWhite: Color { get }
    var grey: Color { get }
    var darkGrey: Color { get }
    var dark2Grey: Color { get }
    var lightGrey: Color { get }
    var black: Color { get }
}

struct AppColors: AnyAppColors, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyAppColors).self) { resolver in
            AppColors()
        }
    }
    
    let white: Color = .init(rgb: 0xFFFFFFFF)
    let offWhite: Color = .init(rgb: 0xFFFAFAFA)
    let grey: Color = .init(rgb: 0xFFDBDBDB)
    let darkGrey: Color = .init(rgb: 0xFF303030)
    let dark2Grey: Color = .init(rgb: 0xFF909090)
    let lightGrey: Color = .init(rgb: 0xFFDEDEDE)
    let black: Color = .init(rgb: 0xFF242424)
}
