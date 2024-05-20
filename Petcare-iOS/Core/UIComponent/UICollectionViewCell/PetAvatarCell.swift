//
//  PetAvatarCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 24.12.2023.
//

import Foundation
import UIKit

final class PetAvatarCell: UICollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dog"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var petName: CustomLabel = {
        let label = CustomLabel(text: "Hola", fontSize: 12, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var petAge: CustomLabel = {
        let label = CustomLabel(text: "5 yo", fontSize: 10, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution  = .fill
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        setupAvatarStyle()
    }
    
    func configure(with pet: PetResponse) {
        petName.text = pet.name
        petAge.text =  pet.birthDate?.calculateAge()
        if let base64Image = pet.image, let image = UIImage(base64String: base64Image) {
            imageView.image = image
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAvatarStyle() {
        contentView.layer.cornerRadius = 20
        layer.cornerRadius = 20
        backgroundColor = AppColors.bgColor
        imageView.layer.cornerRadius = 30 // Yuvarlak görüntü için yarıçapı görüntü boyutunun yarısı yapıyoruz
        imageView.clipsToBounds = true
        addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.4, shadowRadius: 3)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.4, shadowRadius: 3)
    }
}

extension PetAvatarCell: ViewCoding {
    func setupView() {
        contentView.addSubview(stackView)
    }
    
    func setupHierarchy() {
        let views: [UIView] = [imageView, petName, petAge]
        views.forEach { stackView.addArrangedSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])
    }
}
