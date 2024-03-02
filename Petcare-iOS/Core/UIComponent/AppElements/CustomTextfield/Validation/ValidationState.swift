//
//  ValidationState.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import Foundation

//MARK: Equatable Searching

enum ValidationState: Equatable {
    case idle
    case error(ErrorState)
    case valid
    
    enum ErrorState: Equatable {
        case empty
        case invalidEmail
        case invalidNumbers
        case toShortPassword
        case passwordNeedsNum
        case passwordNeedsLetters
        case nameCantContainNumbers
        case nameCantContainSpecialChars
        case toShortName
        case custom(String)
        
        var description: String {
            switch self {
            case .empty:
                return "Field is empty."
            case .invalidEmail:
                return "Invalid email."
            case .toShortPassword:
                return "Password is to short."
            case .passwordNeedsNum:
                return "Password needs numbers."
            case .passwordNeedsLetters:
                return "Password needs letters."
            case .nameCantContainNumbers:
                return "Name can't contain any numbers."
            case .nameCantContainSpecialChars:
                return "Name can't contain special characters."
            case .toShortName:
                return "Name is to short."
            case .custom(let text):
                return text
            case .invalidNumbers:
                return "Number needs only numbers."
            }
        }
    }
}
