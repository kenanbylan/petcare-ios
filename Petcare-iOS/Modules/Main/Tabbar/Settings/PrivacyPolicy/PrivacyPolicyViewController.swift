//
//  PrivacyPolicyViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 10.02.2024.
//

import UIKit

protocol PrivacyPolicyViewProtocol: AnyObject { }

class PrivacyPolicyViewController: UIViewController {
    var presenter: PrivacyPolicyPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTitle()
        view.backgroundColor = AppColors.bgColor
        setupTextView()
    }
    
    private func prepareTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter.setTitle() , fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    private func setupTextView() {
        let textView = UITextView()
        textView.isEditable = false
        textView.text = presenter.getPrivacyPolicyText()
        textView.textColor = AppColors.labelColor
        textView.backgroundColor = .clear
        textView.font = AppFonts.medium.font(size: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
