//
//  LoginTextField.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.11.2023.
//

import Foundation
import UIKit

///MARK: - RegisterTextField
final class CustomTextField: UITextField {
    
    //MARK: - Private Property
    private let padding = UIEdgeInsets(top: 0, left: 5.wPercent, bottom: 0, right: 10.wPercent)
    private var isSecureTextEntryToggle = false

    ///MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    ///MARK: - Override Methods
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    ///MARK: - Private Methods
    private func setupTextField() {
        self.isSecureTextEntry = isSecureTextEntryToggle
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 3, height: 3)
        font = AppFonts.medium.font(size: 14)
        borderStyle = .roundedRect
        tintColor = AppColors.primaryColor
    }
}
