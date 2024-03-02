//
//  CustomValidation.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//
import Foundation
import Combine

struct NameValidation: Validatable {
    func validate(publisher: AnyPublisher<String, Never>) -> AnyPublisher<ValidationState, Never> {
        
        Publishers.CombineLatest4(
            isEmpty(publisher: publisher),
            isToShort(publisher: publisher, count: 2),
            hasNumbers(publisher: publisher),
            hasSpecialChars(publisher: publisher)
        )
        .removeDuplicates(by: { prev, curr in
            prev == curr
        })
        .map {
            if $0.0 { return .error(.empty) }
            if $0.1 { return .error(.toShortName) }
            if $0.2 { return .error(.nameCantContainNumbers) }
            if $0.3 { return .error(.nameCantContainSpecialChars) }
            return .valid
        }
        .eraseToAnyPublisher()
    }
}

struct EmailValidation: Validatable {
    func validate(publisher: AnyPublisher<String, Never>) -> AnyPublisher<ValidationState, Never> {
        
        Publishers.CombineLatest(
            isEmpty(publisher: publisher),
            isValidEmail(publisher: publisher)
        )
        .removeDuplicates(by: { prev, curr in
            prev == curr
        })
        .map {
            if $0.0 { return .error(.empty) }
            if !$0.1 { return .error(.invalidEmail) }
            return .valid
        }
        .eraseToAnyPublisher()
    }
}

struct PasswordValidation: Validatable {
    func validate(publisher: AnyPublisher<String, Never>) -> AnyPublisher<ValidationState, Never> {
        
        Publishers.CombineLatest4(
            isEmpty(publisher: publisher),
            isToShort(publisher: publisher, count: 6),
            hasNumbers(publisher: publisher),
            hasLetters(publisher: publisher)
        )
        .removeDuplicates(by: { prev, curr in
            prev == curr
        })
        .map {
            if $0.0 { return .error(.empty) }
            if $0.1 { return .error(.toShortPassword) }
            if !$0.2 { return .error(.passwordNeedsNum) }
            if !$0.3 { return .error(.passwordNeedsLetters) }
            return .valid
        }
        .eraseToAnyPublisher()
    }
}

struct NumberValidation: Validatable {
    func validate(publisher: AnyPublisher<String, Never>) -> AnyPublisher<ValidationState, Never> {
        
        Publishers.CombineLatest(
            isEmpty(publisher: publisher),
            containsOnlyNumbers(publisher: publisher)
        )
        .removeDuplicates(by: { prev, curr in
            prev == curr
        })
        .map {
            if $0.0 { return .error(.empty) }
            if !$0.1 { return .error(.invalidEmail) }
            return .valid
        }
        .eraseToAnyPublisher()
    }
}
