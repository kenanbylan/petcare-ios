import UIKit
import Combine
import SwiftUI

protocol LoginViewProtocol: AnyObject {
    func showAlertMessage(message: String) -> Void
}

final class LoginViewController: UIViewController {
    var presenter: LoginPresenterProtocol!
    
    private lazy var loginAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "patiShape")?.resized(to: CGSize(width: 80, height: 80))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailForm: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "LOGIN_EMAIL_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var passwordForm: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "LOGIN_PASSWORD_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text:"LOGIN_HEADER".localized(), fontSize: 21, fontType: .medium, textColor: AppColors.primaryColor)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var loginButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("LOGIN_TEXT_LOGIN".localized())
            .setBackgroundColor(AppColors.primaryColor)
            .setTitleColor(AppColors.customWhite)
        appbutton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        appbutton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        appbutton.layer.cornerRadius = 20
        return appbutton
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGIN_TEXT_FORGOTPASSWORD".localized(), for: .normal)
        button.titleLabel?.font = AppFonts.regular.font(size: 14)
        button.setTitleColor(AppColors.labelColor, for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var registerPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("LOGIN_TEXT_SIGNUP".localized(), for: .normal)
        button.titleLabel?.font = AppFonts.regular.font(size: 14)
        button.setTitleColor(AppColors.labelColor, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidload()
        style()
        layout()
        setupKeyboardDismissRecognizer()
    }
}

extension LoginViewController {
    func style() {
        view.backgroundColor = AppColors.bgColor
    }
    
    func layout() {
        view.addSubview(stackView)
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(registerPasswordButton)
        
        stackView.addArrangedSubview(loginAvatar)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(emailForm)
        stackView.addArrangedSubview(passwordForm)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            registerPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}


// MARK: - Actions
extension LoginViewController: LoginViewProtocol {
    func showAlertMessage(message: String) {
        showAlert(for: message)
    }
    
    // MARK: - Button Actions
    @objc func forgotPasswordButtonTapped(_ sender: Any) {
        presenter?.navigateForgotPassword()
    }
    
    @objc func loginButtonTapped(_ sender: Any) {
        validateTextfield()
    }
    
    @objc func signUpButtonTapped(_ sender: Any) {
        presenter?.navigateSignUp()
    }
    
    private func validateTextfield() {
        do {
            let email = try emailForm.validatedText(validationType: .email)
            let password = try passwordForm.validatedText(validationType: .password)
            let data = LoginRequest(email: email, password: password)
            presenter.saveUser(data)
            presenter.navigateMain()
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
}
