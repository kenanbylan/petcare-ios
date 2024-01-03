//
//  UIStackView + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 30.12.2023.
//

import UIKit

extension UIStackView {
    func addSeparator(of size: CGFloat) {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        if axis == .vertical {
            view.heightAnchor.constraint(equalToConstant: size).isActive = true
        } else {
            view.widthAnchor.constraint(equalToConstant: size).isActive = true
        }
        addArrangedSubview(view)
    }
}
