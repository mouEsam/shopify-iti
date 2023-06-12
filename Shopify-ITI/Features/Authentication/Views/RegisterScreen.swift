//
//  RegisterScreen.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 12/06/2023.
//

import Foundation
import SwiftUI

struct RegisterScreen: View {
    
    @EnvironmentObject private var container: AppContainer
    
    @State private var validationError: String?
    @StateObject private var viewModel: RegisterViewModel
    
    init(container: AppContainer) {
        let repo = container.require((any AnyAuthenticationRepository).self)
        _viewModel = .init(wrappedValue: RegisterViewModel(repository: repo))
    }
    
    var body: some View {
        ScrollView {
            Group {
                TextField("Enter First Name", text: $viewModel.firstName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = viewModel.firstNameError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            
            Group {
                TextField("Enter Last Name", text: $viewModel.lastName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = viewModel.lastNameError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            Group {
                TextField("Enter Email", text: $viewModel.email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.lowercase)
                    .textInputAutocapitalization(.never)
                if let error = viewModel.emailError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            Group {
                TextField("Enter Phone", text: $viewModel.phone)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textCase(.lowercase)
                    .textInputAutocapitalization(.never)
                if let error = viewModel.phoneError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            Group {
                TextField("Enter Password", text: $viewModel.password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                if let error = viewModel.passwordError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            
            Button("Submit") {
                Task {
                    await viewModel.register()
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
