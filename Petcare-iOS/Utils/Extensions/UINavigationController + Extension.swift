//
//  UINavigationController + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.

import UIKit

extension UINavigationController {
    func customizeNavigationBar(titleColor: UIColor, titleFont: UIFont, backButtonColor: UIColor) {
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: titleColor,
            NSAttributedString.Key.font: AppFonts.font(for: .medium, size: 19)
        ]
        
        navigationBar.tintColor = backButtonColor
        navigationItem.backBarButtonItem?.tintColor = backButtonColor
    }
}
