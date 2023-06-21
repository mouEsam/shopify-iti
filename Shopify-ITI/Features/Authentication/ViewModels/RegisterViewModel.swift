//
//  RegisterViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 11/06/2023.
//

import Foundation
import Combine

class RegisterViewModel: ObservableObject {
    
    private let repository: any AnyAuthenticationRepository
    
    private let emailValidator = EmailValidator() // TODO: inject
    private let requiredValidator = RequiredValidator<String>() // TODO: inject
    private lazy var confirmPasswordValidator = ValueValidator(validator: { (value: String?) in
        if let password = value,
           password != self.password {
            return RegisterValidationErrors.invalidConfirmPassword
        }
        return nil
    })
    
    @Published private(set) var operationState: UIState<User> = .initial
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published private(set) var firstNameError: String?
    @Published private(set) var lastNameError: String?
    @Published private(set) var emailError: String?
    @Published private(set) var phoneError: String?
    @Published private(set) var passwordError: String?
    @Published private(set) var confirmPasswordError: String?
    
    init(repository: any AnyAuthenticationRepository) {
        self.repository = repository
    }
    
    func validate() {
        firstNameError = requiredValidator.validate(firstName)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
        
        lastNameError = requiredValidator.validate(lastName)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
        
        emailError = emailValidator.validate(email)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
        
        phoneError = requiredValidator.validate(phone)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
        
        passwordError = requiredValidator.validate(password)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
        
        confirmPasswordError = confirmPasswordValidator.validate(confirmPassword)
            .map { $0.message }
            .map { NSLocalizedString($0, comment: $0) }
    }
    
    func register() async {
        await MainActor.run {
            self.validate()
        }
        
        guard firstNameError == nil,
              lastNameError == nil,
              emailError == nil,
              phoneError == nil,
              passwordError == nil,
        confirmPasswordError == nil else { return }
        
        await MainActor.run {
            operationState = .loading
        }
        let credentials = SignupCredentials(firstName: firstName,
                                            lastName: lastName,
                                            email: email,
                                            phone: phone,
                                            password: password)
        let result = await repository.signup(with: credentials)
        await MainActor.run {
            switch result {
                case .success(let user):
                    operationState = .loaded(data: SourcedData.remote(user))
                    break
                case .failure(let error):
                    operationState = .error(error: error)
                    break
            }
        }
    }
}
