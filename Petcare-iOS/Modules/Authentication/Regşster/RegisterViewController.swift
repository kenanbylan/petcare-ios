//
//  RegisterViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func updateCreateButtonState(isEnabled: Bool, color: UIColor)
}

final class RegisterViewController: BaseViewController {
    
    //MARK: Variable's
    var presenter: RegisterPresenterProtocol!
    var isExpand: Bool = false
    
    //MARK: SETUP UI Property
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text:"REGISTER_HEADER_LABEL".localized(), fontSize: 27, fontType: .semibold, textColor: AppColors.primaryColor)
        return label
    }()
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var nameTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "REGISTER_NAME_PLACEHOLDER".localized()
        
        return textfield
    }()
    
    
    private lazy var lastTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "REGISTER_LASTNAME_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var emailTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "REGISTER_EMAIL_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var passwordTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.isSecureTextEntryToggle = true
        textfield.placeholder = "REGISTER_PASSWORD_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var confirmPasswordTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "REGISTER_CONFIRM_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var createAccountButton: LoadingUICustomButton = {
        let button = LoadingUICustomButton()
        button.setupButton(title: "REGISTER_CREATE_BUTTON".localized() , textSize: .medium)
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        setupTextfieldObservers()
    }
    
    @objc func createButtonTapped() {
        presenter.registerUser(name: "Eren", surname: "Karayılan", email: "karayilan@gmail.com", password: "karayilan")
    }
}

extension RegisterViewController {
    private func setupTextfieldObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: nameTextfield)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChange(_:)), name: UITextField.textDidChangeNotification, object: lastTextfield)
    }
    
    @objc func textfieldDidChange(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else {
            return
        }
    }
    
    @objc func keyboardAppear(notification: Notification) {
        guard !self.isExpand, let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect = self.view.frame
        aRect.size.height -= keyboardSize.height
        if !aRect.contains(self.createAccountButton.frame.origin) {
            self.scrollView.scrollRectToVisible(self.createAccountButton.frame, animated: true)
        }
        
        self.isExpand = true
    }
    
    @objc func keyboardDidAppear() {
        if isExpand {
            self.scrollView.contentInset = UIEdgeInsets.zero
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
            self.isExpand = false
        }
    }
}

extension RegisterViewController: ViewCoding {
    func setupView() {
        navigationController?.customizeNavigationBar()
        self.title =  "REGISTER_HEADER".localized()
        self.view.backgroundColor = AppColors.bgColor
    }
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerLabel)
        let stackViewElements = [nameTextfield, lastTextfield, emailTextfield, passwordTextfield, confirmPasswordTextfield]
        
        for i in stackViewElements {
            stackView.addArrangedSubview(i)
        }
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(createAccountButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            ///MARK: ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ///MARK: HeaderLabel
            headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            ///MARK: StackView Label
            stackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            
            ///MARK: Create Account Button
            stackView.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -30),
            createAccountButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            createAccountButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            createAccountButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50),
        ])
    }
}

extension RegisterViewController: RegisterViewProtocol {
    func updateCreateButtonState(isEnabled: Bool, color: UIColor) {
        createAccountButton.isEnabled = isEnabled
        createAccountButton.backgroundColor = color
    }
}
