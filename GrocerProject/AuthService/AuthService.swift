//
//  AuthService.swift
//  GrocerProject
//
//  Created by Farooq Ahmad on 17/05/2025.
//

import Foundation

protocol AuthServiceProtocol {
    func login(email: String, password: String) async throws -> String
}

class AuthService: AuthServiceProtocol {
    private let validEmail = "test@example.com"
    private let validPassword = "12345678"

    func login(email: String, password: String) async throws -> String {
        try await Task.sleep(nanoseconds: 5_000_000_000)
        if email == validEmail && password == validPassword {
            return UUID().uuidString
        } else {
            throw NSError(domain: "Invalid credentials", code: 401)
        }
    }
}
