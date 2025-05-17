//
//  LoginViewModel.swift
//  GrocerProject
//
//  Created by Farooq Ahmad on 17/05/2025.
//

import Foundation

class LoginViewModel {
    
    private let authService: AuthServiceProtocol
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    var onEmailValidation: ((String?) -> Void)?
    var onPasswordValidation: ((String?) -> Void)?

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }

    func validate(email: String, password: String) -> String? {
        if !isValidEmail(email) {
            return "Invalid email format"
        }
        if password.count < 8 {
            return "Password must be at least 8 characters"
        }
        return nil
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }

    func liveValidateForEmail(email: String) {
        if isValidEmail(email) {
            onEmailValidation?(nil)
        } else {
            onEmailValidation?("Invalid email format")
        }
    }
    
    func liveValidateForPassword(password: String) {
        if password.count >= 8 {
            onPasswordValidation?(nil)
        } else {
            onPasswordValidation?("Password must be at least 8 characters")
        }
    }

    func login(email: String, password: String) {
        if let error = validate(email: email, password: password) {
            onLoginFailure?(error)
            return
        }

        onLoadingStateChange?(true)
        Task {
            do {
                let token = try await authService.login(email: email, password: password)
                KeychainManager.set("userToken", value: token)
                DispatchQueue.main.async {
                    self.onLoadingStateChange?(false)
                    self.onLoginSuccess?()
                }
            } catch {
                DispatchQueue.main.async {
                    self.onLoadingStateChange?(false)
                    self.onLoginFailure?("Login failed. Check credentials.")
                }
            }
        }
    }
}
