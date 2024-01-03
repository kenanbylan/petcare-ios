//
//  NewPasswordViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.11.2023.
//

import UIKit

class NewPasswordViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text: "NEWPASSWORD_HEADER_LABEL".localized(), fontSize: 21, fontType: .semibold, textColor: AppColors.primaryColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var subTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "NEWPASSWORD_SUBTITLE_LABEL".localized("kenan.baylan@gmail.com"), fontSize: 21, fontType: .semibold, textColor: AppColors.labelColor)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var newPasswordTextfield: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "NEWPASSWORD_RESET_TEXTFIELD".localized()
        textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var confirmPasswordTextfield: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "NEWPASSWORD_CONFIRM_RESET_TEXTFIELD".localized()
        textfield.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var resetPasswordButton: LoadingUICustomButton = {
        let button = LoadingUICustomButton()
        button.setupButton(title: "NEWPASSWORD_RESET_BUTTON".localized(), textSize: .medium)
        button.addTarget(self, action: #selector(resetPasswordButtonClicked), for: .touchUpInside)
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
    }
    
    @objc func resetPasswordButtonClicked() {
        
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
