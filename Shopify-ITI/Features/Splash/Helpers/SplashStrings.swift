//
//  SplashStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation

protocol AnySplashStrings {
    var onboardingLabel: String { get }
    var onboardingSublabel: String { get }
    var onboardingAction: String { get }
    var onboardingSkip: String { get }
}

// TODO: localize
struct SplashStrings: AnySplashStrings, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnySplashStrings).self) { resolver in
            SplashStrings()
        }
    }
    
    let onboardingLabel: String = "Get your needs and more"
    let onboardingSublabel: String = "The best place where you discover the most wonderful houshold needs and more"
    let onboardingAction: String = "Get Started"
    let onboardingSkip: String = "Skip"
}
