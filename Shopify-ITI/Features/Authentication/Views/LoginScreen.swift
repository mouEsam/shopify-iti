//
//  LoginScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import SwiftUI

struct LoginScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer) {
            self.init(identifier: String(describing: Self.self)) {
                LoginScreen(container: container)
            }
        }
    }
    
    private let strings: any AnyAuthenticationStrings
    private let colors: any AnyAppColors
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    
    @State private var validationError: String?
    @StateObject private var viewModel: LoginViewModel
    
    init(container: AppContainer) {
        strings = container.require((any AnyAuthenticationStrings).self)
        colors = container.require((any AnyAppColors).self)
        let repo = container.require((any AnyAuthenticationRepository).self)
        _viewModel = .init(wrappedValue: LoginViewModel(repository: repo))
    }
    
    var body: some View {
        VStack(spacing: 16) {
            AuthTopBarDecor(barColor: colors.grey,
                             circleColor: colors.black)
            .alignmentGuide(.top) { dimen in dimen[.top] }
            
            ScrollView {
                Spacer().frame(height: 12)
                VStack {
                    Text(strings.loginLabel.localized)
                        .font(.title)
                    Text(strings.loginSublabel.localized)
                        .font(.largeTitle)
                        .textCase(.uppercase)
                        .fontWeight(.semibold)
                }
                AuthCard(shadowColor: colors.dark2Grey.opacity(0.3),
                         backgroundColor: colors.white) {
                    AuthTextField(text: $viewModel.email,
                                  label: strings.emailLabel,
                                  hint: strings.emailHint,
                                  error: viewModel.emailError,
                                  strokeColor: colors.dark2Grey)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    
                    AuthTextField(text: $viewModel.password,
                                  label: strings.passwordLabel,
                                  hint: strings.passwordHint,
                                  error: viewModel.passwordError,
                                  strokeColor: colors.dark2Grey,
                                  obsecurable: true)
                    Button(strings.forgotPassword.localized) {
                        // TODO: implement
                    }
                    RoundedButton(label: strings.loginAction.localized,
                               labelColor: colors.white,
                               backgroundColor: colors.black,
                               isLoading: viewModel.operationState.isLoading) {
                        Task {
                            await viewModel.login()
                        }
                    }
                    Button(strings.signupAction.localized) {
                        router.push(RegisterScreen.Route(container: container))
                    }
                }.buttonStyle(.plain)
                Spacer()
            }
        }
        .disabled(viewModel.operationState.isLoading)
        .onReceive(viewModel.$operationState, perform: { state in
            if state.isLoaded {
                router.pop()
            } else if let error = state.error {
                router.alert(item: ErrorWrapper(error: error)) { wrapper in
                    Alert(title: Text("Error"), // TODO: localize
                          message: Text(wrapper.error.localizedDescription))
                }
            }
        })
        .toolbar(.hidden)
        .onBackSwipe {
            router.pop()
        }
    }
}
