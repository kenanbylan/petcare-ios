//
//  CustomSecurityPassword.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 28.11.2023.
//

import Foundation
import UIKit

class CustomSecurityPassword: UIView {
    
    var isSecurityToggle: Bool = true {
        didSet {
            updateSecurityVisibility()
        }
    }
    
    var textfield: UITextField = {
        let textfield = UITextField()
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    private var securityToggleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.fill"), for: .selected)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        prepareUI()
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
        buildLayout()
    }
    
    private func prepareUI() {
        securityToggleButton.addTarget(self, action: #selector(toggleSecurity), for: .touchUpInside)
        
        textfield.font = AppFonts.medium.font(size: .small)
        textfield.tintColor = AppColors.primaryColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 14.0
        layer.borderColor = AppColors.borderColor?.cgColor        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc private func toggleSecurity() {
        isSecurityToggle.toggle()
    }
    
    private func updateSecurityVisibility() {
        textfield.isSecureTextEntry = isSecurityToggle
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard let previousTraitCollection = previousTraitCollection else { return }
        if traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle {
            print("User Interface Style Changed")
            layer.borderColor = AppColors.borderColor?.cgColor
        }
    }
}

extension CustomSecurityPassword: ViewCoding {
    func setupView() {
        
    }
    
    func setupConstraints() {
        addSubview(textfield)
        addSubview(securityToggleButton)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        securityToggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Set up constraints for textfield
            textfield.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textfield.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textfield.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            textfield.trailingAnchor.constraint(equalTo: securityToggleButton.leadingAnchor, constant: -8),
            
            // Set up constraints for securityToggleButton
            securityToggleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            securityToggleButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            securityToggleButton.widthAnchor.constraint(equalToConstant: 24),
            securityToggleButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupHierarchy() {
        
    }
}

