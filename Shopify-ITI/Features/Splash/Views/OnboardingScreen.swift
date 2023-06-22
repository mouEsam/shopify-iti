//
//  OnboardingScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct OnboardingScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer) {
            self.init(identifier: String(describing: Self.self)) {
                OnboardingScreen(container: container)
            }
        }
    }
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    private let colors: AnyAppColors = AppColors()
    private let strings: AnySplashStrings = SplashStrings()
    
    private let nanoSecondsInSecond: UInt64 = 1_000_000_000
    private let animationDuration: UInt64 = 2
    private let visibilityDuration: UInt64 = 3
    @State private var isVisible = false
    @State private var task: Task<Any, Error>? = nil
    
    private var authManager: AuthenticationManager
    
    init(container: AppContainer) {
        self.authManager = container.require(AuthenticationManager.self)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("onboarding")
                .resizable()
                .ignoresSafeArea(.all)
            VStack(alignment: .trailing) {
                Button(strings.onboardingSkip) {
                    task?.cancel()
                    task = Task {
                        _ = await authManager.setGuest(guest: Guest())
                    }
                }
                .buttonStyle(.bordered)
                .padding()
                VStack(alignment: .leading) {
                    Text(strings.onboardingLabel)
                        .font(.title)
                        .fontWeight(.bold)
                        .textCase(.uppercase)
                    Spacer().frame(height: 30)
                    Text(strings.onboardingSublabel)
                        .font(.caption)
                        .textCase(.uppercase)
                        .foregroundColor(colors.adaptiveGrey)
                }.frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.horizontal)
                Spacer()
                RoundedButton(label: strings.onboardingAction,
                              labelColor: colors.white,
                              backgroundColor: colors.black) {
                    router.push(LoginScreen.Route(container: container))
                }.padding()
            }
        }
        .toolbar(.hidden)
        .onReceive(authManager.statePublisher) { state in
            if case .unauthenticated = state { return }
            router.replace(MainScreen.Route(container: container))
        }
    }
}
