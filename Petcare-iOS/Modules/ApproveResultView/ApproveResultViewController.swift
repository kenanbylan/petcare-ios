//
//  VeterinaryApproveViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.03.2024.
//

import UIKit

final class ApproveResultViewController: UIViewController {
    
    
    // MARK: - Properties
    private let backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let textLabel: CustomLabel = {
        let label = CustomLabel(fontSize: 32, fontType: .semibold, textColor: .white)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel: CustomLabel = {
        let label = CustomLabel(fontSize: 16, fontType: .regular, textColor: .white)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var approveImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = AppFonts.bold.font(size: 18)
        button.backgroundColor = .white
        button.setTitleColor(AppColors.primaryColor, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    init(with model: ApproveResultModel) {
        super.init(nibName: nil, bundle: nil)
        backgroundView.image = UIImage(named: model.backgroundImageName)
        textLabel.text = model.title
        subTitleLabel.text = model.subTitle
        approveImage.image = UIImage(named: model.imageName)?.withRenderingMode(.alwaysTemplate).resized(to: CGSize(width: 50, height: 50))
        doneButton.setTitle(model.buttonTitle, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        view.addSubview(backgroundView)
        view.addSubview(textLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(approveImage)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            approveImage.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            approveImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: approveImage.bottomAnchor, constant: 20),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Public Methods
    func configure(with model: ApproveResultModel) {
        backgroundView.image = UIImage(named: model.backgroundImageName)
        textLabel.text = model.title
        subTitleLabel.text = model.subTitle
        approveImage.image = UIImage(named: model.imageName)?.withRenderingMode(.alwaysTemplate).resized(to: CGSize(width: 50, height: 50))
        doneButton.setTitle(model.buttonTitle, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func doneButtonTapped() {
        print("Approve Done button clicked")
        navigationController?.popToRootViewController(animated: true)
    }
}
