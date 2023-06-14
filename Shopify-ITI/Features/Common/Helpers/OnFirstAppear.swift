//
//  OnFirstAppear.swift
//  Shopify-ITI
//
//  Created by ammar on 15/06/2023.
//

import SwiftUI

struct OnFirstAppearModifier: ViewModifier {
    let perform:() -> Void
    @State private var firstTime: Bool = true
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if firstTime {
                    firstTime = false
                    self.perform()
                }
            }
    }
}

struct OnFirstTaskModifier: ViewModifier {
    let perform:() async -> Void
    @State private var firstTime: Bool = true
    
    func body(content: Content) -> some View {
        content
            .task {
                if firstTime {
                    firstTime = false
                    await self.perform()
                }
            }
    }
}

extension View {
    func onFirstAppear( perform: @escaping () -> Void ) -> some View {
        return self.modifier(OnFirstAppearModifier(perform: perform))
    }
    func onFirstTask( perform: @escaping () async -> Void ) -> some View {
        return self.modifier(OnFirstTaskModifier(perform: perform))
    }
}

