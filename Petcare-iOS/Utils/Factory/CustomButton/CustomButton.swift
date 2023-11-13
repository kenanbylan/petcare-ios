//
//  CustomButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import UIKit

class CustomButton: UIButton {
    private var isLoading = false
    var theme: CustomButtonTheme? {
        didSet {
            applyTheme(theme)
        }
    }

    func applyTheme(_ theme: CustomButtonTheme?) {
        guard let theme = theme else { return }
        self.setTitle(theme.title, for: .normal)
        self.setImage(theme.image, for: .normal)
        self.backgroundColor = theme.backgroundColor
        self.tintColor = theme.tintColor
    }

    func showLoading(_ show: Bool) {
        isLoading = show
        if show {
            self.setTitle("Loading...", for: .normal)
            self.isEnabled = false
        } else {
            self.setTitle(theme?.title, for: .normal)
            self.isEnabled = true
        }
    }
}
