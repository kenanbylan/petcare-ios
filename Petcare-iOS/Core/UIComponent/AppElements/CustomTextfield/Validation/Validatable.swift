//
//  Validatable.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import Foundation
import Combine


protocol Validatable {
    func validate(publisher: AnyPublisher<String, Never>) -> AnyPublisher<ValidationState, Never>
}

extension Validatable {
    func isEmpty(publisher: AnyPublisher<String,Never>) -> AnyPublisher< Bool, Never> {
        publisher
            .map { $0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    func isToShort(publisher: AnyPublisher<String, Never>, count: Int) -> AnyPublisher<Bool, Never> {
        publisher
            .map { !($0.count >= count) }
            .eraseToAnyPublisher()
    }
    
    func hasNumbers(publisher: AnyPublisher<String, Never>) -> AnyPublisher<Bool, Never> {
        publisher
            .map { $0.hasNumbers() }
            .eraseToAnyPublisher()
    }
    
    func hasSpecialChars(publisher: AnyPublisher<String, Never>) -> AnyPublisher<Bool, Never> {
        publisher
            .map { $0.hasSpecialCharacters() }
            .eraseToAnyPublisher()
    }
    
    func isValidEmail(publisher: AnyPublisher<String, Never>) -> AnyPublisher<Bool, Never> {
        publisher
            .map { $0.isValidEmail() }
            .eraseToAnyPublisher()
    }
    
    func hasLetters(publisher: AnyPublisher<String, Never>) -> AnyPublisher<Bool, Never> {
        publisher
            .map { $0.contains(where: { $0.isLetter} ) }
            .eraseToAnyPublisher()
    }
    
    
    func containsOnlyNumbers(publisher: AnyPublisher<String, Never>) -> AnyPublisher<Bool, Never> {
        publisher
            .map { $0.containsOnlyNumbers() }
            .eraseToAnyPublisher()
    }
}
