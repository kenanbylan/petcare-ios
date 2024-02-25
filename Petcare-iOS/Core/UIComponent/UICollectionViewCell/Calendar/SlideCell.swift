//
//  CalendarSlideCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.02.2024.
//

import UIKit

final class SlideCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()
    
    private lazy var sliderTitle: CustomLabel = {
        let label = CustomLabel(text: "Veterinarians", fontSize: 17, fontType: .medium, textColor: AppColors.primaryColor)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(image: UIImage?, text: String) {
        self.imageView.image = image
        self.sliderTitle.text = text
    }
    
    private func prepareUI() {
        backgroundColor = .systemGreen
        addSubview(imageView)
        addSubview(sliderTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            sliderTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            sliderTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sliderTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sliderTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
    }
}
