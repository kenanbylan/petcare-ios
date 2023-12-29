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
        contentView.backgroundColor = .red
        backgroundView?.backgroundColor = .green
        // ImageView'in köşelerini yuvarla
        imageView.layer.cornerRadius = 20
//        imageView.frame.size = CGSize(width: 50, height: 50)
        imageView.clipsToBounds = true

        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.8 // Increase opacity for a more pronounced shadow
        contentView.layer.shadowOffset = CGSize(width: 0, height: 4) // Adjust the offset for a higher lift
        contentView.layer.shadowRadius = 20 // Increase the radius for a softer shadow
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
