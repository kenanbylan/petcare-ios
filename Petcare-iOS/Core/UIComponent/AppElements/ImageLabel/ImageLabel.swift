//
//  ImageLabelIcon.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.03.2024.
//

import Foundation
import UIKit

enum ImageLabelAlignment {
    case left, right
}

final class ImageLabel: UIView {
    private let titleLabel: CustomLabel = {
        let label = CustomLabel(text: "", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    var color: UIColor = AppColors.labelColor {
        didSet {
            titleLabel.textColor = color
        }
    }
    
    var imageName: UIImage = UIImage(systemName: "location.circle")! {
        didSet {
            iconImageView.image = imageName.resized(to: CGSize(width: 25, height: 25)).withRenderingMode(.alwaysTemplate)
        }
    }
    
    var alignment: ImageLabelAlignment = .right {
        didSet {
            updateLayout()
        }
    }
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .horizontal, alignment:.center, distribution:.fillEqually, spacing: 8)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(stackView)
        updateLayout()
        
        titleLabel.textColor = color
        iconImageView.tintColor = AppColors.customBlue
        iconImageView.sizeToFit()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }

    private func updateLayout() {
        switch alignment {
        case .left:
            stackView.addArrangedSubview(iconImageView)
            stackView.addArrangedSubview(titleLabel)
        case .right:
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(iconImageView)
        }
    }
}
