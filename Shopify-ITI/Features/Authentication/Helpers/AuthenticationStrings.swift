//
//  AuthenticationStrings.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation

protocol AnyAuthenticationStrings {
    var loginLabel: String { get }
    var loginError: String { get }
    var loginSublabel: String { get }
    var signupSublabel: String { get }
    var forgotPassword: String { get }
    var loginAction: String { get }
    var signupAction: String { get }
    var signupError: String { get }
    var signupSuccess: String { get }
    var signupSuccessMessage: String { get }
    
    var resetSuccess: String { get }
    var resetSuccessMessage: String { get }
    var resetError: String { get }
    
    var resetLabel: String { get }
    var resetEmail: String { get }
    var resetAction: String { get }
    var resetCancel: String { get }
    var resetMessage: String { get }
    
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
    
    let loginLabel = "AuthenticationStrings.loginLabel"
    let loginError = "AuthenticationStrings.loginError"
    let loginSublabel = "AuthenticationStrings.loginSublabel"
    let signupSublabel = "AuthenticationStrings.signupSublabel"
    let forgotPassword = "AuthenticationStrings.forgotPassword"
    let loginAction = "AuthenticationStrings.loginAction"
    let signupAction = "AuthenticationStrings.signupAction"
    let signupError = "AuthenticationStrings.signupError"
    let signupSuccess = "AuthenticationStrings.signupSuccess"
    let signupSuccessMessage = "AuthenticationStrings.signupSuccessMessage"
    
    let resetSuccess = "AuthenticationStrings.resetSuccess"
    let resetSuccessMessage = "AuthenticationStrings.resetSuccessMessage"
    let resetError = "AuthenticationStrings.resetError"
    
    let resetLabel = "AuthenticationStrings.resetLabel"
    let resetEmail = "AuthenticationStrings.resetEmail"
    let resetAction = "AuthenticationStrings.resetAction"
    let resetCancel = "AuthenticationStrings.resetCancel"
    let resetMessage = "AuthenticationStrings.resetMessage"
    
    let alreadyHaveAccount = "AuthenticationStrings.alreadyHaveAccount"
    
    let firstNameLabel = "AuthenticationStrings.firstNameLabel"
    let firstNameHint = "AuthenticationStrings.firstNameHint"
    
    let lastNameLabel = "AuthenticationStrings.lastNameLabel"
    let lastNameHint = "AuthenticationStrings.lastNameHint"
    
    let emailLabel = "AuthenticationStrings.emailLabel"
    let emailHint = "AuthenticationStrings.emailHint"
    
    let phoneLabel = "AuthenticationStrings.phoneLabel"
    let phoneHint = "AuthenticationStrings.phoneHint"
    
    let passwordLabel = "AuthenticationStrings.passwordLabel"
    let passwordHint = "AuthenticationStrings.passwordHint"
    
    let confirmPasswordLabel = "AuthenticationStrings.confirmPasswordLabel"
    let confirmPasswordHint = "AuthenticationStrings.confirmPasswordHint"
    
    
}
