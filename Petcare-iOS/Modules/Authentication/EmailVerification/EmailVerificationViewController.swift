//
//  SmsVerification.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 21.04.2024.

import Foundation
import UIKit

protocol EmailVerificationViewProtocol: AnyObject {
    func showSuccessAlert(message: String, resetPassword: Bool)
    func showErrorAlert(message: String) -> Void
}

final class EmailVerificationViewController: UIViewController {
    var presenter: EmailVerificationPresenterProtocol?
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        return stack
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text: "EmailVerification_header".localized(), fontSize: 17, fontType: .medium, textColor: AppColors.primaryColor)
        return label
    }()
    
    
    private lazy var infoTextLabel: CustomLabel = {
        let email = presenter?.setEmailAddress() ?? "example@gmail.com"
        let labelText = "We sent to code \(email)".localized()
        let label = CustomLabel(text: labelText, fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var verificationTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.keyboardType = .numberPad
        textfield.placeholder = "EmailVerification_textfield".localized()
        return textfield
    }()
    
    private lazy var verificationButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("EmailVerification_button".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(verificationButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        setupKeyboardDismissRecognizer()
    }
    
    @objc func verificationButtonClicked() {
        validateTextfield()
    }
    
    private func validateTextfield() {
        do {
            let code = try verificationTextfield.validatedText(validationType: .number)
            
            self.presenter?.saveCode(code: code)
            self.presenter?.viewDidLoad()
            
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
}

extension EmailVerificationViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = AppColors.bgColor
    }
    
    func setupHierarchy() {
        let myViews = [
            headerLabel,
            infoTextLabel,
            verificationTextfield,
            verificationButton
        ]
        
        for i in myViews {
            view.addSubview(i)
        }
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            headerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            infoTextLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 12),
            infoTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:20),
            infoTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            verificationTextfield.topAnchor.constraint(equalTo: infoTextLabel.bottomAnchor, constant: 15),
            verificationTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verificationTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verificationTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: verificationTextfield.bottomAnchor, constant: 12),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            verificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            verificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            verificationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16.wPercent),
        ])
    }
}

extension EmailVerificationViewController: EmailVerificationViewProtocol {
    func showSuccessAlert(message: String, resetPassword: Bool) {
        showAlert(title: "Success", message: message, type: .alert) {
            if resetPassword == true {
                self.presenter?.resetPasswordCode()
            } else {
                self.presenter?.navigateLogin()
            }
        }
    }
    
    func showErrorAlert(message: String) {
        showAlert(title: "UYARI", message: message, type: .alert)
    }
}
