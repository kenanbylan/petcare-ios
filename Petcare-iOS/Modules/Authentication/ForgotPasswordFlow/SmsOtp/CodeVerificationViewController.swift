
//  SmsOtpViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 18.11.2023.
//

import UIKit

final class CodeVerificationViewController: UIViewController {
    
    private lazy var stackView: CustomStackView = {
        let stack = CustomStackView()
        return stack
    }()
    
    private lazy var headerLabel: CustomLabel = {
        let label = CustomLabel(text: "SMS_OTP_HEADER_LABEL".localized(), fontSize: 17, fontType: .medium, textColor: AppColors.primaryColor)
        return label
    }()
    
    private lazy var subTitleLabel: CustomLabel = {
        let label = CustomLabel(text: "SMS_OTP_SUBTITLE_LABEL".localized("kenan.baylan@gmail.com"), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var timerLabel: CustomLabel = {
        let label = CustomLabel(text: "00:45", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var resendCodeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.setTitle("SMS_OTP_RESEND_CODE_BUTTON".localized(), for: .normal)
        button.titleLabel?.font = AppFonts.medium.font(size: 14)
        button.addTarget(self, action: #selector(resendButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var verificationTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "SMS_OTP_VERIFICATION_TEXTFIELD".localized()
        return textfield
    }()
    
    private lazy var verificationButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("SMS_OTP_VERIFICATION_BUTTON".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(verificationButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func verificationButtonClicked() {
        print("verificationButtonClicked")
        //        let loadingButton = view.subviews.compactMap { $0 as? LoadingButton }.first
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.present(NewPasswordViewController(), animated: true)
        }
    }
    
    @objc func resendButtonClicked() {
        //tekrardan mail kod gönderilecek.
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
            
            verificationTextfield.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 15),
            verificationTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            verificationTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verificationTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: verificationTextfield.bottomAnchor, constant: 12),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            verificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            verificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            verificationButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16.wPercent),
        ])
    }
}
