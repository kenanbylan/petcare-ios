//
//  PetAvatarCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 24.12.2023.
//

import Foundation
import UIKit

final class PetAvatarCell: UICollectionViewCell {
    
    var model: PetAvatarModel = .init(petImage: "", petName: "", petAge: "") {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.imageView.image = UIImage(named: self.model.petImage!)
                self.petName.text = self.model.petName
                self.petAge.text = self.model.petAge
            }
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dog"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var petName: CustomLabel = {
        let label = CustomLabel(text: "Hola", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var petAge: CustomLabel = {
        let label = CustomLabel(text: "2 years", fontSize: 12, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        setupAvatarStyle()
    }
    
    private func setupAvatarStyle() {
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true

        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        
        layer.shadowColor = AppColors.labelColor.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.cornerRadius = 20
        
        backgroundColor = AppColors.bgColor2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PetAvatarCell: ViewCoding {
    func setupView() {
        contentView.addSubview(stackView)
    }
    
    func setupHierarchy() {
        let views: [UIView] = [
            imageView,
            petName,
            petAge
        ]
        
        views.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.6), // Adjust the multiplier as needed
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor), // Maintain aspect ratio
            
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
        ])
    }
}
