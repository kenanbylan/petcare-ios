//
//  CustomLabel.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.

import Foundation
import UIKit

class CustomLabel: UILabel {
    init(text: String, fontSize: CGFloat, fontType: AppFonts , textColor: UIColor) {
        super.init(frame: .zero)
        commonInit()
        self.text = text
        self.font = fontType.font(size: fontSize)
        self.textColor = textColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        adjustsFontSizeToFitWidth = true
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        numberOfLines = 0
    }
}

