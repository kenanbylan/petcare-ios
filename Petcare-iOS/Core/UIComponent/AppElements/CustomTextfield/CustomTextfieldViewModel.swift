//
//  CustomTextfieldViewModel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import UIKit

extension CustomTextField {
    struct ViewModel {
        
        var type: TextFieldType
        var placeholder: String?
        
        init(type: TextFieldType, placeholder: String? = nil) {
            self.type = type
            self.placeholder = placeholder == nil ? type.defaultPlaceholder() : placeholder
        }
        
        var isSecure: Bool {
            type == .password ? true : false
        }
        
        var keyboardType: UIKeyboardType {
            switch type {
            case .name, .password:
                return .default
            case .email:
                return .emailAddress
            case .numberFloat, .numberInt:
                return .numberPad
            }
        }
    
        var autoCap: UITextAutocapitalizationType {
            type == .name ? .words : .none
        }
    }
}
