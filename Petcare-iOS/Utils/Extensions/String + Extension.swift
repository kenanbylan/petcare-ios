//
//  String + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 19.11.2023.
//

import Foundation

extension String {
    var localizedString: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(format: localizedString, args)
    }
    
    func hasNumbers() -> Bool {
        return stringFulfillsRegex(regex: ".*[0-9].*")
    }
    
    func hasSpecialCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[^A-Za-z0-9].*")
    }
    
    func isValidEmail() -> Bool {
        return stringFulfillsRegex(regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    }
    
    private func stringFulfillsRegex(regex: String) -> Bool {
        let textTest = NSPredicate(format: "SELF MATCHES %@", regex)
        guard textTest.evaluate(with: self) else {
            return false
        }
        return true
    }
    
    func containsOnlyNumbers() -> Bool {
        return stringFulfillsRegex(regex: "^\\d*\\.?\\d+$")
    }
}
