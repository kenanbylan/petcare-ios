//
//  ReminderCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.03.2024.
//

import Foundation
import UIKit

final class ReminderCell: UICollectionViewCell {
    
    private lazy var reminderTitle: CustomLabel = {
        let label = CustomLabel(text: "Food", fontSize: 19, fontType: .medium, textColor: AppColors.primaryColor)
        return label
    }()
    
    private lazy var reminderSubtitle: CustomLabel = {
        let label = CustomLabel(text: "Boncuk sleep time", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var trashButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = AppColors.customBlue
        button.addTarget(self, action: #selector(handleTrashButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var timeLabel: CustomLabel = {
        let label = CustomLabel(text: "Every weekday / 09.00 - 22.00", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupView() {
        contentView.backgroundColor = AppColors.bgColor2
        contentView.layer.cornerRadius = 20
        
        // Add shadow layer
        contentView.addShadow(
            shadowColor: AppColors.customDarkGray.cgColor,
            shadowOffset:CGSize(width: 2.0, height: 4.0),
            shadowOpacity: 0.7,
            shadowRadius: 4.0)
        
        contentView.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(horizontalStackView)
        contentStackView.addArrangedSubview(reminderSubtitle)
        contentStackView.addArrangedSubview(timeLabel)
        
        horizontalStackView.addArrangedSubview(reminderTitle)
        horizontalStackView.addArrangedSubview(UIView()) // Spacer
        horizontalStackView.addArrangedSubview(trashButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            timeLabel.centerXAnchor.constraint(equalTo: contentStackView.centerXAnchor),
        ])
    }

    // Add animation for button tap (example using a basic scale animation)
    @objc private func handleTrashButtonTap(_ sender: UIButton) {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1.0
        animation.toValue = 0.9
        animation.duration = 0.1
        animation.repeatCount = 2
        animation.autoreverses = true
        trashButton.layer.add(animation, forKey: nil)
        
        // Handle actual trash button functionality here (e.g., call delegate method)
    }
}
