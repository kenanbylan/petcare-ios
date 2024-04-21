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

final class ForgotPasswordViewController: UIViewController {
    var presenter: ForgotPasswordPresenterProtocol?
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "FORGOTPASSWORD_TITLE".localized()
        label.numberOfLines = 3
        label.tintColor = AppColors.labelColor
        label.font = AppFonts.medium.font(size: 14)
        label.textAlignment = .justified
        
        return label
    }()
    
    private lazy var emailTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Email"
        return textfield
    }()
    
    private lazy var sendCodeButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("FORGOTPASSWORD_BUTTON".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(sendCodeButtonClicked), for: .touchUpInside)
        return appbutton
    }()

    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "FORGOTPASSWORD_HEADER".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        setupKeyboardDismissRecognizer()
        navigationController?.customizeNavigationBar()
    }
    
    @objc func sendCodeButtonClicked() {
        validateTextfield()
    }
    
    private func validateTextfield() {
        do {
            let email = try emailTextfield.validatedText(validationType: .email)
            let data = ForgotPasswordRequest(email: email)
            //presenter.saveUser(data)
            presenter?.navigateToSmsOtp()
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
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
