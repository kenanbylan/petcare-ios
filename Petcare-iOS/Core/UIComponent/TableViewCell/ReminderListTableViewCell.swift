//
//  ReminderListTableViewCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.05.2024.
//

import UIKit

final class ReminderListTableViewCell: UITableViewCell {
    static let identifier = "ReminderListTableViewCell"
    
    private lazy var reminderTitle: CustomLabel = {
        let label = CustomLabel(text: "", fontSize: 17, fontType: .medium, textColor: AppColors.labelColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reminderSubtitle: CustomLabel = {
        let label = CustomLabel(text: "", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var reminderDate: CustomLabel = {
        let label = CustomLabel(text: "", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 8)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareViews()
    }
    
    func configure(with reminder: Reminder) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy, h:mm a"
        
        reminderTitle.text = reminder.title
        reminderSubtitle.text = reminder.subtitle
        reminderDate.text = formatter.string(from: reminder.date)
        
        if reminder.date < Date() {
            reminderTitle.textColor = AppColors.customDarkGray
            reminderSubtitle.textColor = AppColors.customDarkGray
            reminderDate.textColor = AppColors.customDarkGray
        } else {
            reminderTitle.textColor = AppColors.labelColor
            reminderSubtitle.textColor = AppColors.labelColor
            reminderDate.textColor = AppColors.labelColor
        }
    }
    
    private func prepareViews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(reminderTitle)
        stackView.addArrangedSubview(reminderSubtitle)
        stackView.addArrangedSubview(reminderDate)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
