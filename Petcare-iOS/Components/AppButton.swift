//
//  AppButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
import UIKit

class UICustomButton: UIButton {
    var title: String {
        didSet {
            self.setTitle(self.title, for: .normal)
        }
    }
    
    var radius: CGFloat {
        didSet {
            self.layer.cornerRadius = self.radius
        }
    }
    var font: (size: CGFloat, weight: UIFont.Weight) {
        didSet {
            self.titleLabel?.font = UIFont.systemFont(ofSize: self.font.size, weight: self.font.weight)
        }
    }
    
    var background: UIColor {
        didSet {
            self.backgroundColor = self.background
        }
    }
    
    init(title: String = "Get Started" , radius: CGFloat = 10, font: (size: CGFloat, weight: UIFont.Weight) = (0,.bold), background: UIColor = AppColors.customDarkGray) {
        self.title = title
        self.radius = radius
        self.font = font
        self.background = background
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UICustomButton {
    func setupButton(
        title: String,
        radius: CGFloat = 10,
        font: (size: CGFloat, weight: UIFont.Weight),
        background: UIColor = AppColors.customDarkGray
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerCurve = .circular
        self.clipsToBounds = true
        self.title = title
        self.radius = radius
        self.font = font
        self.background = background
    }
}
