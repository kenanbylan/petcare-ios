//
//  CustomTextfield + TextfieldType.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import Foundation

extension CustomTextField {
    enum TextFieldType: String {
        case name
        case email
        case password
        
        func defaultPlaceholder() -> String {
            return "Enter your \(self.rawValue)..."
        }
    }
}
