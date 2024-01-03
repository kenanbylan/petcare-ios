//
//  UILabel + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

extension UILabel {
    func configurationTitleLabel(withText: String, fontSize: CGFloat, textColor: UIColor) {
        self.text = text
        self.font = AppFonts.bold.font(size: fontSize)
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.sizeToFit()
    }
}
