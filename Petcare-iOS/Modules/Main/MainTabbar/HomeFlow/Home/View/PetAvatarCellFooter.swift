//
//  PetAvatarCellFooter.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 20.03.2024.
//

import Foundation
import UIKit

protocol PetAvatarFooterDelegate {
    func navigateToNewPet() -> Void
}

final class PetAvatarCellFooter: UICollectionReusableView {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus.circle")?.withRenderingMode(.alwaysTemplate))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var petAdd: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = AppColors.primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupAvatarStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    
    func setupView() {
        addSubview(petAdd)
        NSLayoutConstraint.activate([
            petAdd.centerXAnchor.constraint(equalTo: centerXAnchor),
            petAdd.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func setupAvatarStyle() {
        imageView.tintColor = AppColors.primaryColor
        layer.cornerRadius = 20
        layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        clipsToBounds = true
        addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2),shadowOpacity: 0.4,shadowRadius: 3)
    }
}

extension PetAvatarCellFooter {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2),shadowOpacity: 0.4,shadowRadius: 3)
    }
}
