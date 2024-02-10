//
//  SettingTableViewCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.01.2024.
//

import UIKit

final class SettingTableViewCell: UITableViewCell {
    static let identifier = "SettingTableViewCell"
    
    private var iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var stackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withAxis(.horizontal)
            .withLayoutMargins(top: 0, left: 12, bottom: 0, right: 12)
            .withBackgroundColor(.systemRed)
            .build()
    }()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AppColors.primaryColor
        return imageView
    }()
    
    private lazy var settingsLabel: CustomLabel = {
        let label = CustomLabel(text: "Preferences", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingsLabel)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true     //TODO: Research me
        accessoryType = .disclosureIndicator //TODO: Research me
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size : CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        let imageSize : CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        
        settingsLabel.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
    }
    
    public func configureCell(with model: SettingsModel) {
        self.settingsLabel.text = model.title
        self.iconContainer.backgroundColor = model.iconBackgroundColor
        self.iconImageView.image = model.icon
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        settingsLabel.text = nil
        iconImageView.image = nil
        iconContainer.backgroundColor = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
