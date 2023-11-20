
//  SmsOtpViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.11.2023.
//

import UIKit

class SmsOtpViewController: UIViewController, UITextFieldDelegate {
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please Check your Email"
        label.textColor = AppColors.primaryColor
        label.font = AppFonts.semibold.font(size: 21)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "We have sent to kenan.baylan4654@gmail.com"
        label.tintColor = AppColors.labelColor
        label.font = AppFonts.semibold.font(size: 17)
        label.textAlignment = .justified
        
        return label
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:54"
        label.tintColor = AppColors.labelColor
        label.font = AppFonts.semibold.font(size: 17)
        
        return label
    }()
    
    
    private lazy var resendCodeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.setTitle("Send code again", for: .normal)
        button.addTarget(self, action: #selector(resendButtonClicked), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var verificationTextfield: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Please entry code"
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var verificationButton: UICustomButton = {
        let button = UICustomButton()
        button.setupButton(title: "Verification", textSize: .medium)
        button.addTarget(self, action: #selector(verificationButtonClicked), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func verificationButtonClicked() {
        
    }
    
    @objc func resendButtonClicked() {
        
    }
}

extension SmsOtpViewController: ViewCoding {
    func setupView() {
        self.view.backgroundColor = AppColors.bgColor
    }
    
    func setupHierarchy() {
        let myViews = [
            headerLabel,
            subTitleLabel,
            verificationTextfield,
            verificationButton
        ]
        
        stackView.addArrangedSubview(resendCodeButton)
        stackView.addArrangedSubview(timerLabel)
        
        for i in myViews {
            view.addSubview(i)
        }
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            
            subTitleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant:20),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            
            verificationTextfield.heightAnchor.constraint(equalToConstant: 50),
            verificationTextfield.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 15),
            verificationTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verificationTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verificationTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: verificationTextfield.bottomAnchor, constant: 12),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            verificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            verificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -40),
            verificationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            verificationButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
