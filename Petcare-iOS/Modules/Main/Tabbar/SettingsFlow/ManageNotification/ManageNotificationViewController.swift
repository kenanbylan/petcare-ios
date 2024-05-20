//
//  ManageNotificationViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol ManageNotificationViewProtocol: AnyObject { }


final class ManageNotificationViewController: UIViewController {
    var presenter: ManageNotificationPresenterProtocol!
    
    private let emailSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.onTintColor = AppColors.primaryColor
        switchControl.addTarget(self, action: #selector(emailSwitchChanged(_:)), for: .valueChanged)
        return switchControl
    }()
    
    private let pushNotificationSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = AppColors.primaryColor
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(pushNotificationSwitchChanged(_:)), for: .valueChanged)
        return switchControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTitle()
        setupUI()
    }
    
    private func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    private func setupUI() {
        view.backgroundColor = AppColors.bgColor
        
        // Add email switch
        view.addSubview(emailSwitch)
        NSLayoutConstraint.activate([
            emailSwitch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            emailSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        let emailLabel = CustomLabel(text: "ManageNotificationView_email".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        view.addSubview(emailLabel)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailLabel.centerYAnchor.constraint(equalTo: emailSwitch.centerYAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailSwitch.trailingAnchor, constant: 10)
        ])
        
        // Add separator
        let separatorView = UIView()
        separatorView.backgroundColor = .systemGray5 // You can use any color you want
        view.addSubview(separatorView)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: emailSwitch.bottomAnchor, constant: 10),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        // Add push notification switch
        view.addSubview(pushNotificationSwitch)
        NSLayoutConstraint.activate([
            pushNotificationSwitch.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            pushNotificationSwitch.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        let pushNotificationLabel = CustomLabel(text: "ManageNotificationView_nofity".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        
        view.addSubview(pushNotificationLabel)
        pushNotificationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pushNotificationLabel.centerYAnchor.constraint(equalTo: pushNotificationSwitch.centerYAnchor),
            pushNotificationLabel.leadingAnchor.constraint(equalTo: pushNotificationSwitch.trailingAnchor, constant: 10)
        ])
        
        
        // Set initial switch values based on presenter
        emailSwitch.isOn = presenter.shouldReceiveEmails
        pushNotificationSwitch.isOn = presenter.shouldReceivePushNotifications
    }
    
    
    @objc private func emailSwitchChanged(_ sender: UISwitch) {
        presenter.updateNotificationSettings(email: sender.isOn, pushNotification: pushNotificationSwitch.isOn)
    }
    
    @objc private func pushNotificationSwitchChanged(_ sender: UISwitch) {
        presenter.updateNotificationSettings(email: emailSwitch.isOn, pushNotification: sender.isOn)
    }
    
}
