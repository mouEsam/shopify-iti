//
//  SigninViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    
    private let repository: any AnyAuthenticationRepository
    
    private let emailValidationGroup = ValidationGroup<String>()
    private let emailValidator = EmailValidator() // TODO: inject
    private let requiredValidator = RequiredValidator<String>() // TODO: inject
    
    @Published private(set) var operationState: UIState<Session> = .initial
    @Published private(set) var resetState: UIState<Void> = .initial
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published private(set) var emailError: String?
    @Published private(set) var passwordError: String?
       
    private var loginTask: Task<Void, Error>? = nil
    private var resetTask: Task<Void, Error>? = nil
    
    init(repository: some AnyAuthenticationRepository) {
        self.repository = repository
        
        emailValidationGroup.add(validator: emailValidator)
        emailValidationGroup.add(validator: requiredValidator)
    }
    
    func validate() {
        emailError = emailValidationGroup.validate(email)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
        
        passwordError = requiredValidator.validate(password)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
    }
    
    func login() {
        loginTask?.cancel()
        loginTask = Task {
            await MainActor.run {
                self.validate()
            }

            guard passwordError == nil,
                  emailError == nil else { return }
            
            await MainActor.run {
                operationState = .loading
            }
            let result = await repository.login(with: SigninCredentials(email: email, password: password))
            await MainActor.run {
                switch result {
                    case .success(let session):
                        dump(session)
                        operationState = .loaded(data: SourcedData.remote(session))
                        break
                    case .failure(let error):
                        operationState = .error(error: error)
                        break
                }
            }
        }
    }
    
    func reset(email: String) {
        resetTask?.cancel()
        resetTask = Task {
            await MainActor.run {
                resetState = .loading
            }
            let result = await repository.recover(email: email)
            await MainActor.run {
                switch result {
                    case .success(_):
                        resetState = .loaded(data: SourcedData.remote(Void()))
                        break
                    case .failure(let error):
                        resetState = .error(error: error)
                        break
                }
            }
        }
    }
}
