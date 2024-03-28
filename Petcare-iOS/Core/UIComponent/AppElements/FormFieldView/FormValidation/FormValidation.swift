//
//  FormValidation.swift
//  Petcare-iOS
//  Created by Kenan Baylan on 23.03.2024.
//


import Foundation
import UIKit


struct FormValidation {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

