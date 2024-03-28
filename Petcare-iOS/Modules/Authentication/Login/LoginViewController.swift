import UIKit
import Combine
import SwiftUI

protocol LoginViewProtocol: AnyObject {
    func loginUserControl()
}

final class LoginViewController: UIViewController {
    // MARK: Variables
    var isExpanded: Bool = false
    
    private lazy var loginAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cat")?.resized(to: CGSize(width: 60, height: 60))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var emailForm: FormFieldView = {
        let form = FormFieldView()
        form.label.text = "EMAİL"
        return form
    }()
    
    private lazy var passwordForm: FormFieldView = {
        let form = FormFieldView()
        form.label.text = "Password"
        return form
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text:"Welcome back to PetCare!", fontSize: 24, fontType: .medium, textColor: AppColors.primaryColor)
        return label
    }()
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        
        return stack
    }()
    
    private lazy var  signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var  googleSignInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Google Sign In", for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(googleSignInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = AppFonts.regular.font(size: 14)
        button.tintColor = AppColors.labelColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var  forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot Password", for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: LoginPresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        presenter.viewDidload()
        style()
        layout()
    }
}

extension LoginViewController {
    
    func style() {
        stackView.backgroundColor = .systemGreen
    }
    
    func layout() {
        view.addSubview(stackView)
        view.addSubview(loginButton)
        stackView.addArrangedSubview(loginAvatar)
        stackView.addArrangedSubview(headerLabel)
        stackView.addArrangedSubview(emailForm)
        stackView.addArrangedSubview(passwordForm)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            emailForm.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            passwordForm.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,constant: -20),
            
        ])
    }
}

// MARK: - Actions

extension LoginViewController {
    
    @objc func undoTapped() {
        emailForm.undo()
    }
    
    // MARK: - Button Actions
    @objc func forgotPasswordButtonTapped(_ sender: Any) {
        presenter?.navigateForgotPassword()
    }
    
    @objc func loginButtonTapped(_ sender: Any) {
        presenter?.navigateMain()
    }
    
    @objc func signUpButtonTapped(_ sender: Any) {
        presenter?.navigateSignUp()
    }
    
    @objc func googleSignInButtonTapped(_ sender: Any) {
        //        presenter?.controlGoogleSignIn()
    }
    
    private func prepareKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        // Handle keyboard show event
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        // Handle keyboard hide event
    }
}

// MARK: - Factories

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 60/4
    return button
}



struct LoginVC_Previews: PreviewProvider {
    static var previews: some View {
        LoginViewController().showPreview()
    }
}
