//
//  LoadingButton.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 22.11.2023.
//

import UIKit

class LoadingUICustomButton: UIButton {
    var activityIndicator: UIActivityIndicatorView!
    let activityIndicatorColor: UIColor = .gray
    
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
                UIView.animate(withDuration: 0.2) {
                    self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.transform = .identity
                }
            }
        }
    }
    
    init(title: String = "Get Started", radius: CGFloat = 20, font: UIFont? = nil, background: UIColor = AppColors.primaryColor) {
        self.title = title
        self.radius = radius
        self.font = font ?? AppFonts.medium.font(size: .medium)
        self.background = background
        super.init(frame: .zero)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 13.wPercent).isActive = true
        self.layer.cornerCurve = .circular
        self.clipsToBounds = true
    }
    
    func loadIndicator(_ shouldShow: Bool) {
        if shouldShow {
            if (activityIndicator == nil) {
                activityIndicator = createActivityIndicator()
            }
            self.isEnabled = false
            self.alpha = 0.7
            showSpinning()
        } else {
            activityIndicator.stopAnimating()
            self.isEnabled = true
            self.alpha = 1.0
        }
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = activityIndicatorColor
        return activityIndicator
    }
    
    private func showSpinning() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(activityIndicator)
        positionActivityIndicatorInButton()
        activityIndicator.startAnimating()
    }
    
    private func positionActivityIndicatorInButton() {
        let trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: activityIndicator,
                                                    attribute: .trailing,
                                                    multiplier: 1, constant: 16)
        self.addConstraint(trailingConstraint)
        
        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.addConstraint(yCenterConstraint)
    }
}

extension LoadingUICustomButton {
    func setupButton(
         title: String,
         radius: CGFloat = 20,
         font: UIFont? = nil,
         textSize: LabelSize = .small,
         background: UIColor = AppColors.primaryColor
     ) {
         self.title = title
         self.radius = radius
         self.font = font ?? AppFonts.medium.font(size: textSize.rawValue)
         self.background = background
         configureButton()
     }
}
