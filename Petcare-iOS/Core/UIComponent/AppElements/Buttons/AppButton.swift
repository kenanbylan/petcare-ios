//
//  PatiButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.
//

import UIKit
import Combine

final class AppButton: UIButton {
    var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
            adjustContent()
        }
    }
    
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
            adjustContent()
        }
    }
    
    var titleColor: UIColor? {
        didSet {
            setTitleColor(titleColor, for: .normal)
        }
    }
    
    var imageColor: UIColor? {
        didSet {
            if let color = imageColor {
                imageView?.tintColor = color
            }
        }
    }
    
    private init() {
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    static func build() -> AppButton {
        return AppButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animateButton(scaleX: 0.95, y: 0.95)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animateButton(scaleX: 1.0, y: 1.0)
    }
    
    private func animateButton(scaleX: CGFloat, y: CGFloat) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: scaleX, y: y)
        }, completion: nil)
    }
    
    private func adjustContent() {
        if let image = image, let title = title {
            setImage(image, for: .normal)
            setTitle(title, for: .normal)
        } else if let title = title {
            setTitle(title, for: .normal)
            setImage(nil, for: .normal)
        } else {
            setImage(image, for: .normal)
            setTitle(nil, for: .normal)
        }
    }
    
    private func configureButton() {
        titleColor = AppColors.primaryColor
        titleLabel?.font = AppFonts.medium.font(size: 14)
        layer.cornerRadius = 20
        layer.borderWidth = 1.5
        layer.borderColor = AppColors.borderColor?.cgColor
        clipsToBounds = false
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        contentHorizontalAlignment = .center
        contentVerticalAlignment = .center
        
        if #available(iOS 15.0, *) {
            var newConfiguration = UIButton.Configuration.plain()
            newConfiguration.imagePadding = 12
            newConfiguration.titlePadding = 12
            configuration = newConfiguration
        }
    }
    
    @discardableResult
    func setImage(_ image: UIImage?) -> AppButton {
        self.image = image
        return self
    }
    
    @discardableResult
    func setTitle(_ title: String?) -> AppButton {
        self.title = title
        return self
    }
    
    @discardableResult
    func setFont(_ font: UIFont = AppFonts.medium.font(size: 14)!) -> AppButton {
        titleLabel?.font = font
        return self
    }
    
    @discardableResult
    func setImageColor(_ imageColor: UIColor) -> AppButton {
        self.imageColor = imageColor
        return self
    }
    
    @discardableResult
    func setTintColor(_ tintColor: UIColor) -> AppButton {
        self.tintColor = tintColor
        return self
    }
    
    @discardableResult
    func setBackgroundColor(_ backgroundColor: UIColor?) -> AppButton {
        self.backgroundColor = backgroundColor
        return self
    }
    
    @discardableResult
    func setTitleColor(_ titleColor: UIColor) -> AppButton {
        self.titleColor = titleColor
        return self
    }
}

extension AppButton {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        addShadow(shadowColor: AppColors.bgColor.cgColor)
        layer.borderColor = AppColors.borderColor?.cgColor
    }
}
