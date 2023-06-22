//
//  RegisterScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation
import SwiftUI

struct RegisterScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer) {
            self.init(identifier: String(describing: Self.self)) {
                RegisterScreen(container: container)
            }
        }
    }
    
    private let strings: any AnyAuthenticationStrings
    private let colors: any AnyAppColors
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    @State private var validationError: String?
    @StateObject private var viewModel: RegisterViewModel
    
    init(container: AppContainer) {
        strings = container.require((any AnyAuthenticationStrings).self)
        colors = container.require((any AnyAppColors).self)
        let repo = container.require((any AnyAuthenticationRepository).self)
        _viewModel = .init(wrappedValue: RegisterViewModel(repository: repo))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            AuthTopBarDecor(barColor: colors.grey,
                             circleColor: colors.black)
            .alignmentGuide(.top) { dimen in dimen[.top] }
            
            ScrollView {
                Spacer().frame(height: 16)
                
                VStack {
                    Text(strings.signupSublabel.localized)
                        .font(.largeTitle)
                        .textCase(.uppercase)
                        .fontWeight(.semibold)
                }
                
                AuthCard(shadowColor: colors.dark2Grey.opacity(0.3),
                         backgroundColor: colors.white) {
                    HStack {
                        AuthTextField(text: $viewModel.firstName,
                                      label: strings.firstNameLabel,
                                      hint: strings.firstNameHint,
                                      error: viewModel.firstNameError,
                                      strokeColor: colors.dark2Grey)
                        AuthTextField(text: $viewModel.lastName,
                                      label: strings.lastNameLabel,
                                      hint: strings.lastNameHint,
                                      error: viewModel.lastNameError,
                                      strokeColor: colors.dark2Grey)
                    }
                    AuthTextField(text: $viewModel.email,
                                  label: strings.emailLabel,
                                  hint: strings.emailHint,
                                  error: viewModel.emailError,
                                  strokeColor: colors.dark2Grey)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    AuthTextField(text: $viewModel.phone,
                                  label: strings.phoneLabel,
                                  hint: strings.phoneHint,
                                  error: viewModel.phoneError,
                                  strokeColor: colors.dark2Grey).keyboardType(.phonePad)
                    AuthTextField(text: $viewModel.password,
                                  label: strings.passwordLabel,
                                  hint: strings.passwordHint,
                                  error: viewModel.passwordError,
                                  strokeColor: colors.dark2Grey,
                                  obsecurable: true)
                    AuthTextField(text: $viewModel.confirmPassword,
                                  label: strings.confirmPasswordLabel,
                                  hint: strings.confirmPasswordHint,
                                  error: viewModel.confirmPasswordError,
                                  strokeColor: colors.dark2Grey,
                                  obsecurable: true)
                    RoundedButton(label: strings.signupAction,
                                  labelColor: colors.white,
                                  backgroundColor: colors.black,
                                  isLoading: viewModel.operationState.isLoading) {
                        Task {
                            await viewModel.register()
                        }
                    }
                    Button {
                        router.pop()
                    } label: {
                        Group {
                            Text(strings.alreadyHaveAccount.localized)
                                .foregroundColor(colors.dark2Grey)
                            + Text(" ")
                            + Text(strings.loginAction.localized)
                                .foregroundColor(colors.black)
                                .fontWeight(.bold)
                        }
                    }

                }.buttonStyle(.plain)
                Spacer()
            }
        }
        .disabled(viewModel.operationState.isLoading)
        .onReceive(viewModel.$operationState) { state in
            if state.isLoaded {
                router.pop()
            } else if let error = state.error {
                router.alert(item: ErrorWrapper(error: error)) { wrapper in
                    Alert(title: Text(strings.signupError),
                          message: wrapper.error.text)
                }
            }
        }
        .toolbar(.hidden)
        .onBackSwipe {
            router.pop()
        }
    }
}
