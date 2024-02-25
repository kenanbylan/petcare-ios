//
//  AlertView.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 17.02.2024.
//

import Foundation
import UIKit

enum AlertViewType {
    case singleButton
    case multiButton
}


final class AlertView: UIView {
    
    var primaryAction: (() -> Void)?
    var secondaryAction: (() -> Void)?
    static let shared = AlertView()

    
    private let parentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let alertTitle: CustomLabel = {
        let label = CustomLabel(text: "Test", fontSize: 20, fontType: .bold, textColor: AppColors.primaryColor)
        label.textAlignment = .center
        return label
    }()
    
    private let alertDescriptionLabel: CustomLabel = {
        let label = CustomLabel(text: "DescriptionLabel", fontSize: 16, fontType: .medium, textColor: AppColors.customRed)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let primaryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAlert(title: String, message: String, buttonType: AlertViewType, onPrimaryTapped: (() -> Void)?, onSecondaryTapped: (() -> Void)?) {
        self.alertTitle.text = title
        self.alertDescriptionLabel.text = message
        
        
//        if let keyWindow = UIApplication.shared.keyWindow {
//            keyWindow.addSubview(parentView)
//            parentView.frame = keyWindow.bounds
//        }
        
        if let keyWindowScene = UIApplication.shared.connectedScenes.first(where: {
            $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let keyWindow = keyWindowScene.windows.first(where: { $0.isKeyWindow }) {
                keyWindow.addSubview(parentView)
            }
        }
        
        switch buttonType {
        case .singleButton:
            primaryButton.setTitle("primaryTitle", for: .normal)
            cancelButton.isHidden = true
        case .multiButton:
            primaryButton.setTitle("primaryTitle", for: .normal)
            cancelButton.setTitle("secondaryTitle", for: .normal)
            cancelButton.isHidden = false
        }
        
        primaryAction = onPrimaryTapped
        secondaryAction = onSecondaryTapped
    }
    
    @objc private func primaryButtonTapped() {
        dismissAlert()
        primaryAction?()
    }
    
    @objc private func secondaryButtonTapped() {
        dismissAlert()
        secondaryAction?()
    }
    
    private func dismissAlert() {
        parentView.removeFromSuperview()
    }
    
    private func setupUI() {
        parentView.addSubview(alertView)
        alertView.addSubview(alertTitle)
        alertView.addSubview(alertDescriptionLabel)
        alertView.addSubview(primaryButton)
        alertView.addSubview(cancelButton)
        
        primaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(secondaryButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertTitle.translatesAutoresizingMaskIntoConstraints = false
        alertDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        primaryButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: parentView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: parentView.centerYAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 300),
            
            alertTitle.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            alertTitle.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            alertTitle.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            alertDescriptionLabel.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 8),
            alertDescriptionLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            alertDescriptionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            primaryButton.topAnchor.constraint(equalTo: alertDescriptionLabel.bottomAnchor, constant: 16),
            primaryButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            primaryButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            primaryButton.heightAnchor.constraint(equalToConstant: 50),
            
            cancelButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 8),
            cancelButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            cancelButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -16)
        ])
    }
    
}

