//
//  ValidationManager.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.04.2024.

import Foundation

protocol ValidationRule {
    func isValid(_ text: String?) -> Bool
    var errorMessage: String { get }
}

struct Rule: ValidationRule {
    let regex: String
    let errorMessage: String

    func isValid(_ text: String?) -> Bool {
        guard let text = text else { return false }
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
}

extension String {
    func validate(rules: [ValidationRule]) -> String? {
        for rule in rules {
            if !rule.isValid(self) {
                return rule.errorMessage
            }
        }
        return nil
    }
}

class Validators {
    static let shared = Validators()
    private init() {}

    func validate(_ text: String?, with rules: [ValidationRule]) -> String? {
        return text?.validate(rules: rules)
    }
}
