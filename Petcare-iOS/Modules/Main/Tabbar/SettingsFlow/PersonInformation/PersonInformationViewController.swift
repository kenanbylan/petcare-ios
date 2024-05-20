//
//  PersonInformationViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol PersonInformationViewProtocol: AnyObject {
    func showAlertMessage(message: String)
    func showAlertFailure(message: String)
}

final class PersonInformationViewController: UIViewController {
    var presenter: PersonInformationPresenterProtocol!
    
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
    
    private lazy var nameTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.isEnabled = false
        textfield.placeholder = "REGISTER_NAME_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var lastTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.isEnabled = false
        textfield.placeholder = "REGISTER_LASTNAME_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var emailTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.isEnabled = false
        textfield.placeholder = "REGISTER_EMAIL_PLACEHOLDER".localized()
        return textfield
    }()
    
    private lazy var accountSave: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("Kaydet".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(accountSaveTapped), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewDidload()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTitle()
        view.backgroundColor = AppColors.bgColor
        buildLayout()
        setupKeyboardDismissRecognizer()
    }
    
    private func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    @objc func accountSaveTapped() {
        presenter.navigateToRoot()
    }
}

extension PersonInformationViewController: ViewCoding {
    func setupView() {
        navigationController?.customizeNavigationBar()
        self.title =  "REGISTER_HEADER".localized()
        self.view.backgroundColor = AppColors.bgColor
    }
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        let stackViewElements = [nameTextfield, lastTextfield, emailTextfield]
        
        for i in stackViewElements {
            stackView.addArrangedSubview(i)
        }
        
        scrollView.addSubview(stackView)
        scrollView.addSubview(accountSave)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            ///MARK: ScrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            ///MARK: StackView Label
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            
            ///MARK: Create Account Button
            stackView.bottomAnchor.constraint(equalTo: accountSave.topAnchor, constant: -30),
            accountSave.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            accountSave.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            accountSave.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50),
        ])
    }
}

extension PersonInformationViewController: PersonInformationViewProtocol {
    func showAlertMessage(message: String) {
        DispatchQueue.main.async {
            self.nameTextfield.text = self.presenter.personInformation?.name
            self.lastTextfield.text = self.presenter.personInformation?.surname
            self.emailTextfield.text = self.presenter.personInformation?.email
        }
    }
    
    func showAlertFailure(message: String) { }
}
