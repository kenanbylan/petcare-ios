//
//  AppointmentList.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.
//

import Foundation
import UIKit

final class AppointmentListTableViewCell: UITableViewCell {
    static let identifier = "AppointmentListTableViewCell"
    
    private lazy var titleName: CustomLabel = {
        let label = CustomLabel(text: "Kenan Baylan", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var dateLabel: CustomLabel = {
        let label = CustomLabel(text: "12 Mart 2024", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var timeLabel: CustomLabel = {
        let label = CustomLabel(text: "Saat 10.00", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var detailInfo: CustomLabel = {
        let label = CustomLabel(text: "Fino köpeğin aşı günü", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configuration(with appoitment: AppointmentModel) {
        self.titleName.text = appoitment.rezervationName
        self.dateLabel.text = appoitment.date
        self.timeLabel.text = appoitment.time
        self.detailInfo.text = appoitment.info
    }
    
    private func setupUI() {
        contentView.addSubview(topStackView)
        contentView.addSubview(detailInfo)
        
        topStackView.addArrangedSubview(titleName)
        topStackView.addArrangedSubview(dateLabel)
        topStackView.addArrangedSubview(timeLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            detailInfo.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8),
            detailInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
}
