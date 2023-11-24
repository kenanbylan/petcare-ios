//
//  Validations.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 24.11.2023.
//

import Foundation

enum ValidationType {
    case email
    case password
    case name(minLength: Int, maxLength: Int)
    case confirmPassword(originalPassword: String)
}

func ValidationControl(_ input: String, validationType: ValidationType) -> Bool {
    switch validationType {
    case .email:
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: input)
    case .password:
        let passwordRegex = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+\\-={}\\[\\]:;\"<>,.?/~])\\S{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: input)
        
    case .name(minLength: let minLength, maxLength: let maxLength):
        return (minLength...maxLength).contains(input.count)
        
    case .confirmPassword(originalPassword: let originalPassword):
        return input == originalPassword
    }
}
