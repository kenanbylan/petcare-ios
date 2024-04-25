//
//  RegisterViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 6.11.2023.

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
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private let typeRegisterSegmentedControl: UISegmentedControl = {
        let items = ["REGISTER_USER".localized(), "REGISTER_VET".localized()]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0 // Default to Male
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
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
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    private lazy var confirmPasswordTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "REGISTER_CONFIRM_PLACEHOLDER".localized()
        textfield.isSecureTextEntry = true
        
        return textfield
    }()
    
    private lazy var createAccountButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("REGISTER_CREATE_BUTTON".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        presenter.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear), name: UIResponder.keyboardDidHideNotification, object: nil)
        
        setupKeyboardDismissRecognizer()
        setupTextfieldObservers()
    }
    
    @objc func createButtonTapped() {
        validateTextfield()
    }
    
    private func validateTextfield() {
        do {
            let name = try nameTextfield.validatedText(validationType: .name)
            let lastname = try lastTextfield.validatedText(validationType: .requiredField(field: "REGISTER_LASTNAME".localized()))
            let emailAddress = try emailTextfield.validatedText(validationType: .email)
            let password = try passwordTextfield.validatedText(validationType: .password)
            let confirmPassword = try confirmPasswordTextfield.validatedText(validationType: .confirmPassword(password: password))
            
            var role: ROLE = typeRegisterSegmentedControl.selectedSegmentIndex == 0 ? .USER : .VETERINARY
            let data = UserRegisterRequest(role: role,
                                           name: name,
                                           surname: lastname,
                                           email: emailAddress,
                                           password: password)
            presenter.saveUser(data)
            showAlert(for: role == .USER ? "REGISTER_USER_ALERT".localized() : "REGISTER_VET_ALERT".localized()) {
                role == .USER ? self.presenter.navigateAccountEnable() : self.presenter.navigateToVetAddress()
            }
            
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
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
        guard !self.isExpand, let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
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
        let stackViewElements = [nameTextfield, lastTextfield, emailTextfield, passwordTextfield, confirmPasswordTextfield]
        
        for i in stackViewElements {
            stackView.addArrangedSubview(i)
        }
        
        scrollView.addSubview(typeRegisterSegmentedControl)
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
            
            typeRegisterSegmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 30),
            typeRegisterSegmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 32),
            typeRegisterSegmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -32),
            
            ///MARK: StackView Label
            stackView.topAnchor.constraint(equalTo: typeRegisterSegmentedControl.bottomAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            
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
