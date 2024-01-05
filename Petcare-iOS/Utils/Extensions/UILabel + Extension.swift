//
//  UILabel + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

final class TitleLabel {
    static func configurationTitleLabel(withText: String, fontSize: CGFloat, textColor: UIColor) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = withText
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = AppFonts.bold.font(size: 17)
        titleLabel.textColor = AppColors.primaryColor
        titleLabel.sizeToFit()
        return titleLabel
    }
}
