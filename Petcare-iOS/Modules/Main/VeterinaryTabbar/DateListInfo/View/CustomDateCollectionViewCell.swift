//
//  CustomDate.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 23.04.2024.
//

import Foundation
import UIKit


final class CustomDateCollectionViewCell: UICollectionViewListCell {
    var checkBoxSwitch: UISwitch = {
        let checkBoxSwitch = UISwitch()
        checkBoxSwitch.isOn = false
        checkBoxSwitch.onTintColor = .systemBlue // Seçili durumda mavi
        return checkBoxSwitch
    }()
    
    var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubviews() {
        // Checkbox switch
        contentView.addSubview(checkBoxSwitch)
        checkBoxSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkBoxSwitch.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkBoxSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        // Time label
        contentView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: checkBoxSwitch.trailingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])
    }
    
    func configure(with dateList: DateList) {
        checkBoxSwitch.isOn = dateList.isSelected
        timeLabel.text = dateList.time
    }
}
