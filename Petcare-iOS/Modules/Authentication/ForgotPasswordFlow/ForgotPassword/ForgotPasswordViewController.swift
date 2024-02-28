//
//  ForgotPasswordViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 7.11.2023.
//

import UIKit

protocol ForgotPasswordViewProtocol: AnyObject {
    func forgotPasswordReset()
}

final class ForgotPasswordViewController: UIViewController,UITextFieldDelegate  {
    var presenter: ForgotPasswordPresenterProtocol?
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter the email address with your account and we'll send an email with confirmation to reset your password"
        label.numberOfLines = 3
        label.tintColor = AppColors.labelColor
        label.font = AppFonts.medium.font(size: 14)
        label.textAlignment = .justified
        
        return label
    }()
    
    private lazy var emailTextfield: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Email"
        return textfield
    }()
    
    private lazy var sendCodeButton: LoadingUICustomButton = {
        let button = LoadingUICustomButton()
        button.setupButton(title: "Send Code", textSize: LabelSize.small)
        button.addTarget(self, action: #selector(sendCodeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Forgot Password", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func sendCodeButtonClicked() {
        print("Send code button clicked.")
        present(SmsOtpViewController(), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
         return true
     }
}


extension ForgotPasswordViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = AppColors.bgColor
    }
   
    func setupHierarchy() {
        let myViews = [subTitleLabel, emailTextfield, sendCodeButton]
        for i in myViews {
            view.addSubview(i)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            emailTextfield.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 15),
            emailTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sendCodeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sendCodeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            sendCodeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            
        ])
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    func forgotPasswordReset() { }
}
