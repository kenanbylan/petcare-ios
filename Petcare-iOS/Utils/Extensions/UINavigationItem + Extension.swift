//
//  UINavigationItem + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 4.01.2024.
//

import UIKit

extension UINavigationItem {
    func setCustomBackButtonTitle(_ title: String,color: UIColor) {
        let backButton = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        backButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17)!, NSAttributedString.Key.foregroundColor: color], for: .normal)
        backBarButtonItem = backButton
    }
}
