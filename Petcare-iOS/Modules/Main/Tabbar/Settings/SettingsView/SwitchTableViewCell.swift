//
//  SwitchTableViewCell.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.01.2024.
//

import UIKit

final class SwitchTableViewCell: UITableViewCell {
    
    static let identifier = "SwitchTableViewCell"
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = AppColors.primaryColor
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var settingsLabel: CustomLabel = {
        let label = CustomLabel(text: "Preferences with Switch", fontSize: 17, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let settingsSwitch : UISwitch = {
       let mSwitch = UISwitch()
        mSwitch.onTintColor = .systemBlue
        return mSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(settingsLabel)
        contentView.addSubview(iconContainer)
        contentView.addSubview(settingsSwitch)
        iconContainer.addSubview(iconImageView)
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size : CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        let imageSize : CGFloat = size / 1.5
        iconImageView.frame = CGRect(x: (size - imageSize)/2, y: (size - imageSize)/2, width: imageSize, height: imageSize)
        
        settingsSwitch.sizeToFit()
        settingsSwitch.frame = CGRect(x: contentView.frame.size.width - settingsSwitch.frame.size.width - 20,
                                y: (contentView.frame.size.height - settingsSwitch.frame.size.height)/2,
                                width: settingsSwitch.frame.size.width,
                                height: settingsSwitch.frame.size.height)
        
        settingsLabel.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        settingsLabel.text = nil
        iconContainer.backgroundColor = nil
        settingsSwitch.isOn = false
    }
    
    public func configure(with model: SwitchSettingsModel) {
        settingsLabel.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        settingsSwitch.isOn = model.isOn
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
