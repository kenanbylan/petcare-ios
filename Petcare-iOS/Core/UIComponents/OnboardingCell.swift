//
//  OnboardingCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 8.11.2023.
//

import Foundation
import UIKit

final class OnboardingCell: UICollectionViewCell {
    
    var model: OnboardingModel = .init(image: "", title: "", subtitle: "") {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.title.text = self.model.title
                self.subtitle.text = self.model.subtitle
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "onboard1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
        
    private lazy var title: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = AppColors.customDarkGray
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = AppColors.customDarkGray
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
        
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OnboardingCell: ViewCoding {
    func setupView() {
        
    }
    
    func setupHierarchy() {
        let views: [UIView] = [
            imageView,
            title,
            subtitle
        ]
        
        views.forEach {
            self.addSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            title.topAnchor.constraint(equalToSystemSpacingBelow: imageView.bottomAnchor, multiplier: 5),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.8),
            
            subtitle.topAnchor.constraint(equalToSystemSpacingBelow: title.bottomAnchor, multiplier: 2),
            subtitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subtitle.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.8)
        
        ])
    }
}
