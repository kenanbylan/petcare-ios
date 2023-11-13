//
//  ControlTextfield.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import Foundation
import UIKit


class SecurityTextField: UITextField {
    private let showPasswordImage = UIImage(systemName: "eye.slash")
    private let hidePasswordImage = UIImage(systemName: "eye")
    private var isSecureTextEntryToggle = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.frame.size.height = 55 // Yükseklik ayarı
        self.borderStyle = .none
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.5
        self.clipsToBounds = false

        self.isSecureTextEntry = true

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont(name: "Kanit", size: 16) ?? UIFont.systemFont(ofSize: 16)
        ]

        self.attributedPlaceholder = NSAttributedString(string: "Placeholder Text", attributes: placeholderAttributes)

        let togglePasswordButton = UIButton(type: .custom)
        togglePasswordButton.frame = CGRect(x: 0, y: 0, width: 30, height: self.frame.height)
        togglePasswordButton.setImage(showPasswordImage, for: .normal)
        togglePasswordButton.addTarget(self, action: #selector(toggleSecureTextEntry), for: .touchUpInside)

        self.rightView = togglePasswordButton
        self.rightViewMode = .always
    }

    @objc private func toggleSecureTextEntry() {
        isSecureTextEntryToggle.toggle()
        self.isSecureTextEntry = isSecureTextEntryToggle
        let togglePasswordButton = self.rightView as! UIButton
        togglePasswordButton.setImage(isSecureTextEntryToggle ? showPasswordImage : hidePasswordImage, for: .normal)
    }
}
