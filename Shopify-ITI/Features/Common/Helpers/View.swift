//
//  View.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct BackSwipeModifier: ViewModifier {
    @Environment(\.layoutDirection) private var direction
    let action:() -> Void
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .gesture(DragGesture()
                    .onEnded({ value in
                        let start = direction == .leftToRight ?
                                    value.startLocation.x :
                                    (geometry.size.width - value.startLocation.x)
                        let width = abs(value.translation.width)
                        if start < 35 && width > 80 {
                            action()
                        }
                    }))
        }
    }
}

extension View {
    func onBackSwipe(perform action: @escaping () -> Void) -> some View {
        return self.modifier(BackSwipeModifier(action: action))
    }
}
