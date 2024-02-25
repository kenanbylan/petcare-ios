//
//  PatiButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.11.2023.
//

import UIKit

protocol PatiButtonDelegate: AnyObject {
    func patiButtonClicked(_ sender: PatiButton)
}

final class PatiButton: UIButton {
    weak var delegate: PatiButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }

    private func setupButton() {
        setBackgroundImage(UIImage(named: "pati"), for: .normal)
        addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    
        layer.shadowColor = AppColors.primaryColor.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        clipsToBounds = false
        
        setConstraints()
    }
    
    private func setConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 60).isActive = true
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
        
    @objc private func buttonClicked() {
        delegate?.patiButtonClicked(self)
    }

    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.5) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 1.5, y: 1.5) : .identity
            }
        }
    }
}
