//
//  AuthenticationStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation

protocol AnyAuthenticationStrings {
    var loginLabel: String { get }
    var loginSublabel: String { get }
    var signupSublabel: String { get }
    var forgotPassword: String { get }
    var loginAction: String { get }
    var signupAction: String { get }
    var alreadyHaveAccount: String { get }
    
    var emailLabel: String { get }
    var emailHint: String { get }
    
    var firstNameLabel: String { get }
    var firstNameHint: String { get }
    
    var lastNameLabel: String { get }
    var lastNameHint: String { get }
    
    var phoneLabel: String { get }
    var phoneHint: String { get }
    
    var passwordLabel: String { get }
    var passwordHint: String { get }
    
    var confirmPasswordLabel: String { get }
    var confirmPasswordHint: String { get }
}
// TODO: localize
struct AuthenticationStrings: AnyAuthenticationStrings, AnyInjectable  {
    static func register(_ container: AppContainer) {
        container.register(type: (any AnyAuthenticationStrings).self) { resolver in
            AuthenticationStrings()
        }
    }
    
    let loginLabel = "Hello"
    let loginSublabel = "WelcomeBack"
    let signupSublabel = "Welcome"
    let forgotPassword = "Forgot Password"
    let loginAction = "Login"
    let signupAction = "Sign up"
    let alreadyHaveAccount = "Already have account?"
    
    let firstNameLabel = "First name"
    let firstNameHint = "Your first name"
    
    let lastNameLabel = "Last name"
    let lastNameHint = "Your last name"
    
    let emailLabel = "Email"
    let emailHint = "Your email"
    
    let phoneLabel = "Phone"
    let phoneHint = "Your phone"
    
    let passwordLabel = "Password"
    let passwordHint = "Your password"
    
    let confirmPasswordLabel = "Confirm Password"
    let confirmPasswordHint = "Your password"
}
