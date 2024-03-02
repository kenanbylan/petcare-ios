//
//  ValidatorFactory.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import Foundation

enum ValidatorFactory {
    static func validateForType(type: ValidatorType) -> Validatable {
        switch type {
        case .email:
            return EmailValidation()
        case .password:
            return PasswordValidation()
        case .name:
            return NameValidation()
        case .numbers:
            return NumberValidation()
        }
    }
}
