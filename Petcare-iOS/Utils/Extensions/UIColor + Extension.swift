//
//  UIColor + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 22.11.2023.
//

import UIKit

extension UIColor {
    static func resolvedColor(_ color: UIColor) -> CGColor {
        if #available(iOS 13.0, *) {
            return color.resolvedColor(with: UITraitCollection.current).cgColor

        } else {
            return color.cgColor
        }
    }
}
