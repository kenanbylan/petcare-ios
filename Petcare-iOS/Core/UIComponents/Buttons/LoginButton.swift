//
//  GoogleButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.
//

import Foundation
import UIKit

class LoginButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    // for Storyboard or XIB use
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        setTitle("Login", for: .normal)
        titleLabel?.font = AppFonts.medium.font(size: 19)
        backgroundColor = AppColors.primaryColor
        tintColor = UIColor.darkText
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 3, height: 3)
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        print("Login düğmesine tıklandı.")
    }
}
