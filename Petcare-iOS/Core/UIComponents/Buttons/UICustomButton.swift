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
    var font: UIFont? {
        didSet {
            self.titleLabel?.font = font
        }
    }
    
    var background: UIColor {
        didSet {
            self.backgroundColor = self.background
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                ///MARK: Button is pressed
                UIView.animate(withDuration: 0.2) {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }
            } else {
                ///MARK: Button is released
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
            }
        }
    }
    
    init(title: String = "Get Started", radius: CGFloat = 10, font: UIFont? = nil, background: UIColor = AppColors.customDarkGray) {
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
        textSize: LabelSize,
        background: UIColor = AppColors.customDarkGray
    ) {
        let uiFont = AppFonts.medium.font(size: textSize.rawValue)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerCurve = .circular
        self.clipsToBounds = true
        self.title = title
        self.radius = radius
        self.font = uiFont
        self.background = background
    }
}
