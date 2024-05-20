//
//  NearbyVetView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 16.03.2024.
//

import Foundation
import UIKit

final class NearbyVetView: UIView {
    
    private lazy var veterinaryAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "patiShape")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var veterinaryName: CustomLabel = {
        let label = CustomLabel(text: "Çınar Veterinerlik", fontSize: 17, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var veterinaryDistance: CustomLabel = {
        let label = CustomLabel(text: "Mesafe: 1.2 km", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution  = .fillEqually
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
        prepareVeterinaryViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with nearbyPlace: NearbyPlace) {
        veterinaryName.text = nearbyPlace.placeTitle
        veterinaryDistance.text = formatDistance(nearbyPlace.distance)
    }
    
    func formatDistance(_ distanceString: String) -> String {
        guard let distance = Double(distanceString) else {
            return "Geçersiz mesafe"
        }
        
        if distance < 1000 {
            return String(format: "Uzaklık: %.0f metre mesafe", distance)
        } else {
            let distanceInKilometers = distance / 1000.0
            return String(format: "Uzaklık: %.1f kilometre mesafe", distanceInKilometers)
        }
    }
}

extension NearbyVetView: ViewCoding {
    private func prepareVeterinaryViews() {
        veterinaryAvatar.clipsToBounds = true
        veterinaryAvatar.layer.cornerRadius = 20
        
        backgroundColor = AppColors.bgColor
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = AppColors.customDarkGray.cgColor
        
        veterinaryAvatar.addShadow(shadowColor: AppColors.bgColor.cgColor)
        veterinaryAvatar.layer.cornerRadius = 20
    }
    
    func setupView() {
        self.addSubview(veterinaryAvatar)
        self.addSubview(horizontalStackView)
    }
    
    func setupHierarchy() {
        horizontalStackView.addArrangedSubview(veterinaryName)
        horizontalStackView.addArrangedSubview(veterinaryDistance)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            veterinaryAvatar.topAnchor.constraint(equalTo: self.topAnchor,constant: 12),
            veterinaryAvatar.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 12),
            veterinaryAvatar.heightAnchor.constraint(equalTo: horizontalStackView.heightAnchor, multiplier: 1),
            veterinaryAvatar.widthAnchor.constraint(equalTo: veterinaryAvatar.heightAnchor),
            
            horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor,constant:  12),
            horizontalStackView.leadingAnchor.constraint(equalTo: veterinaryAvatar.trailingAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}

extension NearbyVetView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        veterinaryAvatar.addShadow(shadowColor: AppColors.bgColor.cgColor)
        layer.borderColor = AppColors.customDarkGray.cgColor
    }
}
