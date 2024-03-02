//
//  BaseTextField.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//

import UIKit

class PaddedTextField: UITextField {
    var padding: UIEdgeInsets = .zero
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = AppColors.borderColor?.cgColor
        layer.borderWidth = 1.5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = AppColors.borderColor?.cgColor
        layer.borderWidth = 1.5
    }
}
