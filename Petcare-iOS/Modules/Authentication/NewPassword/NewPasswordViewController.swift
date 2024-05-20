//
//  NewPasswordViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.11.2023.
//

import UIKit

protocol NewPasswordViewProtocol: AnyObject {
    func showAlertMessage(message: String) -> Void
    func showAlertFailure(message: String) -> Void
}

final class NewPasswordViewController: UIViewController {
    var presenter: NewPasswordPresenterProtocol!
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text: "NEWPASSWORD_HEADER_LABEL".localized(), fontSize: 17, fontType: .medium, textColor: AppColors.primaryColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "NEWPASSWORD_SUBTITLE_LABEL".localized(), fontSize: 17, fontType: .regular, textColor: AppColors.labelColor)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var newPasswordTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "NEWPASSWORD_RESET_TEXTFIELD".localized()
        return textfield
    }()
    
    private lazy var confirmPasswordTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "NEWPASSWORD_CONFIRM_RESET_TEXTFIELD".localized()
        return textfield
    }()
    
    private lazy var resetPasswordButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("NEWPASSWORD_RESET_BUTTON".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(resetPasswordButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    @objc func resetPasswordButtonClicked() {
        validateTextfield()
    }
    
    private func validateTextfield() {
        do {
            let newPassword = try newPasswordTextfield.validatedText(validationType: .password)
            let confirmPassword = try confirmPasswordTextfield.validatedText(validationType: .confirmPassword(password: newPassword))
            
            self.presenter?.saveNewPassword(password: newPassword)
            self.presenter.fetchRequest()
            
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
    
}

extension NewPasswordViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = AppColors.bgColor
    }
    
    func setupHierarchy() {
        view.addSubview(resetPasswordButton)
        
        let myViews = [
            headerLabel,
            subTitleLabel,
            newPasswordTextfield,
            confirmPasswordTextfield
        ]
        for i in myViews {
            stackView.addArrangedSubview(i)
        }
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            
            resetPasswordButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            resetPasswordButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            resetPasswordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}

extension NewPasswordViewController: NewPasswordViewProtocol {
    func showAlertMessage(message: String) {
        showAlert(title: "Success", message: message, type: .alert) {
            self.presenter.navigateToLogin()
        }
    }
    
    func showAlertFailure(message: String) {
        showAlert(title: "Please try again code", message: message, type: .alert)
    }
}
