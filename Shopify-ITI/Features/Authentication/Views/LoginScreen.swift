//
//  LoginScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import SwiftUI

struct LoginScreen: View {
    
    @EnvironmentObject private var container: AppContainer

    @State private var validationError: String?
    @StateObject private var viewModel: LoginViewModel
    
    init(container: AppContainer) {
        let repo = container.require((any AnyAuthenticationRepository).self)
        _viewModel = .init(wrappedValue: LoginViewModel(repository: repo))
    }
    
    var body: some View {
        VStack {
            TextField("Enter Email", text: $viewModel.email)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if let error = viewModel.emailError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            TextField("Enter Password", text: $viewModel.password)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if let error = viewModel.passwordError {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Submit") {
                Task {
                    await viewModel.login()
                }
            }
            .disabled(viewModel.emailError == nil &&
                      viewModel.passwordError != nil)
        }
        .onAppear {}
        .padding()
        .onReceive(viewModel.$operationState) { state in
            print(state)
        }
    }
}
