//
//  UINavigationController + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.

import UIKit

extension UINavigationController {
    func customizeNavigationBar() {
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: AppColors.primaryColor,
            NSAttributedString.Key.font: AppFonts.medium.font(size: .medium)
        ]
        navigationBar.tintColor = AppColors.primaryColor
        navigationItem.backBarButtonItem?.tintColor = AppColors.primaryColor
    }
}
