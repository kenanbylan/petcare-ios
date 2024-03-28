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
        let label = CustomLabel(text: "Food", fontSize: 17, fontType: .medium, textColor: AppColors.primaryColor)
        return label
    }()
    
    private lazy var reminderSubtitle: CustomLabel = {
        let label = CustomLabel(text: "Appoiintment with doctor ", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var trashButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "trash.fill"), for: .normal)
        button.tintColor = AppColors.customBlue
        //        button.addTarget(self, action: #selector(toPrevButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var timeLabel: CustomLabel = {
        let label = CustomLabel(text: "09.00 AM - 21.00 PM", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution  = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var insideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buildLayout()
    }
}


extension ReminderCell: ViewCoding {
    func setupView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(insideStackView)
        mainStackView.addArrangedSubview(reminderSubtitle)
        mainStackView.addArrangedSubview(timeLabel)
        
    }
    
    func setupHierarchy() {
        insideStackView.addArrangedSubview(reminderTitle)
        insideStackView.addArrangedSubview(UIView())
        insideStackView.addArrangedSubview(trashButton)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
