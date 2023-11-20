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

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forgot Password"
        label.textColor = AppColors.primaryColor
        label.font = AppFonts.semibold.font(size: 21)
        
        label.textAlignment = .center
        return label
    }()
    
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
        textfield.placeholder = "Email "
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var sendCodeButton: UICustomButton = {
        let button = UICustomButton()
//        button.setupButton(title: "Send Code", font: (size: 16, weight: .semibold))
        button.setupButton(title: "Send Code", textSize: LabelSize.small)
        button.addTarget(self, action: #selector(sendCodeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()

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
        let myViews = [headerLabel, subTitleLabel, emailTextfield, sendCodeButton]
        for i in myViews {
            view.addSubview(i)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            
            subTitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            emailTextfield.heightAnchor.constraint(equalToConstant: 50),
            emailTextfield.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 15),
            emailTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            sendCodeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            sendCodeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -40),
            sendCodeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            sendCodeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension ForgotPasswordViewController: ForgotPasswordViewProtocol {
    func forgotPasswordReset() {
        
    }
}
