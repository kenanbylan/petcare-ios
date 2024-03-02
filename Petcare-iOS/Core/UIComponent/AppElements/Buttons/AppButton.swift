//
//  PatiButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.
//

import UIKit
protocol PatiButtonDelegate: AnyObject {
    func patiButtonClicked(_ sender: AppButton)
}

final class AppButton: UIButton {
    weak var delegate: PatiButtonDelegate?
    
    var image: UIImage? {
        didSet {
            setImage(image, for: .normal)
            adjustContent()
        }
    }
    
    var title: String? = "Continue" {
        didSet {
            setTitle(title, for: .normal)
            adjustContent()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureButton()
    }
    
    private func configureButton() {
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        addShadow(shadowColor: AppColors.bgColor.cgColor)
        layer.cornerRadius = 12
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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        layer.borderColor = AppColors.borderColor?.cgColor
        addShadow(shadowColor: AppColors.bgColor.cgColor)
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
    
    // Düğmeye tıklanma olayını ileten fonksiyon
    @objc private func buttonClicked() {
        delegate?.patiButtonClicked(self)
    }
    
    private func adjustContent() {
        if let image = image, let title = title {
            
            setImage(image, for: .normal)
            setTitle(title, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10) // Görüntüye sağ boşluk ekle
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10) // Metne sol boşluk ekle
        } else if let title = title {
            setTitle(title, for: .normal)
            setImage(nil, for: .normal)
        } else {
            setImage(image, for: .normal)
            setTitle(nil, for: .normal)
        }
    }
}
