//
//  CalendarSlideCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.02.2024.
//

import UIKit

final class SlideCell: UICollectionViewCell {
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        imageView.image = UIImage(named: "info-host")
        return imageView
    }()
    
    private lazy var sliderTitle: CustomLabel = {
        let label = CustomLabel(text: "Veterinarians", fontSize: 14, fontType: .medium, textColor: AppColors.primaryColor)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var textContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(text: String, image: UIImage) {
        self.sliderTitle.text = text
        self.backgroundImageView.image = image
    }
    
    private func prepareUI() {
        backgroundImageView.layer.cornerRadius = 20
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(textContainerView)
        textContainerView.addSubview(sliderTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            textContainerView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            textContainerView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            textContainerView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            
            sliderTitle.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor, constant: 16),
            sliderTitle.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor, constant: -16),
            sliderTitle.topAnchor.constraint(equalTo: textContainerView.topAnchor, constant: 16),
            sliderTitle.bottomAnchor.constraint(equalTo: textContainerView.bottomAnchor, constant: -16),
        ])
    }
}
