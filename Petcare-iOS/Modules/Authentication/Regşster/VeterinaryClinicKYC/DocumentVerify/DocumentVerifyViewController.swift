//
//  DocumentVerifyViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.

import UIKit
import TipKit

protocol DocumentVerifyViewProtocol: AnyObject {
    func forgotPasswordReset()
}

final class DocumentVerifyViewController: UIViewController {
    var presenter: DocumentVerifyPresenterProtocol?

    private let textLabel: CustomLabel = {
        let label = CustomLabel(text: "Veteriner yeterlilik belgenizi PDF veya görsel olarak yükleyiniz.", fontSize: 17, fontType: .semibold, textColor: AppColors.primaryColor)
        return label
    }()
    
    // Sağ üst köşede yer alacak buton.
    private lazy var infoPopupButton: UIButton = {
        let button = UIButton(type: .infoDark)
        button.tintColor = AppColors.primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Belge görüntüleme alanı
    private let documentView: DocumentView = {
        let view = DocumentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
    }
}

extension DocumentVerifyViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = AppColors.bgColor
        title = "Document Verify"
        
    }
    
    func setupHierarchy() {
        view.addSubview(textLabel)
        view.addSubview(documentView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: infoPopupButton)
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            documentView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            documentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            documentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            documentView.heightAnchor.constraint(equalToConstant: 200),
            
            infoPopupButton.widthAnchor.constraint(equalToConstant: 24),
            infoPopupButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
