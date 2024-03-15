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
    
    private var securityToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        return button
    }()
    
    var isSecureTextEntryToggle = false {
        didSet {
            updateSecurityVisibility()
        }
    }
    
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
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        layer.borderColor = AppColors.borderColor?.cgColor
        layer.borderWidth = 1.5
        layer.cornerRadius = 12
        layer.shadowColor = AppColors.customDarkGray.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4

        
        isPasswordTextfield()
    }
    
    private func isPasswordTextfield() {
        if isSecureTextEntryToggle {
            securityToggleButton.addTarget(self, action: #selector(toggleSecurity), for: .touchUpInside)
            rightView = securityToggleButton
            rightViewMode = .always
        } else {
            rightView = nil
            rightViewMode = .never
        }
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
    
    @objc private func toggleSecurity() {
        isSecureTextEntryToggle.toggle()
    }
    
    private func updateSecurityVisibility() {
        self.isSecureTextEntry = !isSecureTextEntryToggle
        securityToggleButton.isSelected = isSecureTextEntryToggle
    }
}

extension CustomTextFieldBase {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1.5
        layer.borderColor = AppColors.primaryColor.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderWidth = 1.5
        layer.borderColor = AppColors.borderColor?.cgColor
    }
}
