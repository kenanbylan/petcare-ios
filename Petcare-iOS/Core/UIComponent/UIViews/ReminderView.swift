//
//  ReminderCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.03.2024.
//

import Foundation
import UIKit

final class ReminderView: UIView {
    
    private lazy var reminderTitle: CustomLabel = {
        let label = CustomLabel(text: "Food", fontSize: 19, fontType: .medium, textColor: AppColors.primaryColor)
        return label
    }()
    
    private lazy var reminderSubtitle: CustomLabel = {
        let label = CustomLabel(text: "Çarşama 15 Mayıs 2024, 8.41 PM", fontSize: 14, fontType: .regular, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 8
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
        backgroundColor = AppColors.bgColor
        layer.cornerRadius = 12
        
        //MARK: Add shadow layer
        addShadow( shadowColor: AppColors.customDarkGray.cgColor, shadowOffset:CGSize(width: 2.0, height: 4.0), shadowOpacity: 0.7, shadowRadius: 4.0)
        
        addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(reminderTitle)
        contentStackView.addArrangedSubview(reminderSubtitle)
        setupConstraints()
    }
    
    func configure(with reminder: Reminder) {
        reminderTitle.text = reminder.title
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy, h:mm a"
        reminderSubtitle.text = formatter.string(from: reminder.date)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}

extension ReminderView {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        addShadow(shadowColor: AppColors.customDarkGray.cgColor,
            shadowOffset:CGSize(width: 2.0, height: 4.0), shadowOpacity: 0.7, shadowRadius: 4.0)
    }
}
