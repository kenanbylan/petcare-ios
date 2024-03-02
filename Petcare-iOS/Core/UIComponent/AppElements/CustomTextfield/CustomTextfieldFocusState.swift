//
//  CustomTextfieldFocusState.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import UIKit

extension CustomTextField {
    enum FocusState {
        case active
        case inActive
        
        var borderColor: CGColor? {
            self == .inActive ? AppColors.borderColor?.cgColor : AppColors.primaryColor.cgColor
        }
        
        var borderWidth: CGFloat {
            self == .active ? 1.5 : 1.5
        }
    }
}
