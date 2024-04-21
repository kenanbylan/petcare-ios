//
//  Validation.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.04.2024.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorsType {
    case name
    case email
    case number
    case phone
    case password
    case confirmPassword(password: String)
    case username
    case requiredField(field: String)
    case age
}

enum ValidatorFactorys {
    static func validatorFor(type: ValidatorsType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        case .name: return NameValidator()
        case .number: return NumberValidator()
        case .phone: return PhoneNumberValidator()
        case .confirmPassword(let password): return ConfirmValidator(password: password)
        }
    }
}

class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than 3 characters" )
        }
        
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 8 else { throw ValidationError("Password must have at least 8 characters") }
        
        let characterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        guard let _ = value.rangeOfCharacter(from: characterSet) else {
            throw ValidationError("Password must contain at least one letter and one number")
        }
        
        return value
    }
}

struct ConfirmValidator: ValidatorConvertible {
    private let password: String
    
    init(password: String) {
        self.password = password
    }
    
    func validated(_ value: String) throws -> String {
        guard value == password else {
            throw ValidationError("Passwords do not match")
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}

struct NameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else { throw ValidationError("Name is Required")}
        
        let characterSet = CharacterSet.letters.union(CharacterSet.whitespaces)
        if value.rangeOfCharacter(from: characterSet.inverted) != nil {
            throw ValidationError("Invalid characters in name")
        }
        return value
    }
}

struct NumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 1 else { throw ValidationError("Value is Required") }
        
        let digitCharacterSet = CharacterSet.decimalDigits
        if value.rangeOfCharacter(from: digitCharacterSet.inverted) != nil {
            throw ValidationError("Invalid characters in number")
        }
        if value.count > 6 {
            throw ValidationError("Number must be at most 6 digits long")
        }
        
        return value
    }
}

struct PhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 1 else { throw ValidationError("Value is Required" ) }
        
        let digitCharacterSet = CharacterSet.decimalDigits
        if value.rangeOfCharacter(from: digitCharacterSet.inverted) != nil {
            throw ValidationError("Invalid characters in phone number")
        }
        if value.count != 10 {
            throw ValidationError("Phone number must be 10 digits long")
        }
        return value
    }
}
