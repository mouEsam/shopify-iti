//
//  SplashScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    private let nanoSecondsInSecond: UInt64 = 1_000_000_000
    private let animationDuration: UInt64 = 2
    private let visibilityDuration: UInt64 = 3
    @State private var isVisible = false
    
    private var authManager: AuthenticationManager

    init(container: AppContainer) {
        self.authManager = container.require(AuthenticationManager.self)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            if isVisible {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 250)
            }
        }
        .ignoresSafeArea(.all)
        .onFirstTask {
            await MainActor.run {
                withAnimation(.easeIn(duration: Double(animationDuration))) {
                    isVisible.toggle()
                }
            }
            try? await Task.sleep(nanoseconds: animationDuration * nanoSecondsInSecond)
            try? await Task.sleep(nanoseconds: visibilityDuration * nanoSecondsInSecond)
            await MainActor.run {
                withAnimation(.easeIn(duration: Double(animationDuration))) {
                    isVisible.toggle()
                }
            }
            try? await Task.sleep(nanoseconds: animationDuration * nanoSecondsInSecond)
            await MainActor.run {
                if case .unauthenticated = authManager.state {
                    router.replace(OnboardingScreen.Route(container: container))
                } else {
                    router.replace(MainScreen.Route(container: container))
                }
            }
        }
    }
}
