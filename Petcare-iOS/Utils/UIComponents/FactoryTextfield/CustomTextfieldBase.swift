//
//  CustomTextfieldBase.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 24.11.2023.
//

import Foundation
import UIKit

class CustomTextFieldBase: UITextField, UITextFieldDelegate {
    
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5.wPercent, bottom: 0, right: 10.wPercent)
    }
    
    var isSecureTextEntryToggle = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupTextField()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
        delegate = self
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    private func setupTextField() {
        self.isSecureTextEntry = isSecureTextEntryToggle
        font = AppFonts.medium.font(size: .small)
        tintColor = AppColors.primaryColor
        borderStyle = .none
        layer.borderWidth = 1.0
        layer.cornerRadius = 14.0
        layer.borderColor = AppColors.borderColor?.cgColor
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let previousTraitCollection = previousTraitCollection else {
            return
        }
        
        if traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle {
            print("User Interface Style Changed")
            layer.borderColor = AppColors.borderColor?.cgColor
        }
    }
}

extension CustomTextFieldBase {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1.0
        layer.borderColor = AppColors.primaryColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 1.0
        layer.borderColor = AppColors.borderColor?.cgColor
    }
}
