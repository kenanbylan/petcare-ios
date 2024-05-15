//
//  PetDetailViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 13.02.2024.
//

import UIKit
import SwiftUI

protocol PetDetailViewProtocol: AnyObject {
    func setupUI()
}

class PetDetailViewController: UIViewController {
    var presenter: PetDetailPresenterProtocol?
    
    private lazy var petsNameLabel: CustomLabel = {
        let label = CustomLabel(text: presenter?.petData.name, fontSize: 21, fontType: .bold, textColor: AppColors.labelColor)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var petImages: UIImageView = {
        let imageView = UIImageView()
        if let base64Image = presenter?.petData.image, let image = UIImage(base64String: base64Image) {
            imageView.image = image
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        return button
    }()
    
    private lazy var specialInfo: CustomLabel = {
        let label = CustomLabel(text: presenter?.petData.specialInfo, fontSize: 17, fontType: .medium, textColor: AppColors.labelColor)
        label.numberOfLines = 0
        return label
    }()
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
    private lazy var headerStackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withAxis(.horizontal)
            .distribution(distribution: .fill)
            .spacing(spacing: 20)
            .build()
    }()
    
    private lazy var infoOutSideStackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withAxis(.vertical)
            .distribution(distribution: .fill)
            .withLayoutMargins(top: 20, left: 20, bottom: 20, right: 20)
            .withCornerRadius(20)
            .build()
    }()
    
    private lazy var informationSideStackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withAxis(.vertical)
            .distribution(distribution: .fill)
            .withLayoutMargins(top: 20, left: 20, bottom: 20, right: 20)
            .withCornerRadius(20)
            .build()
    }()
    
    private lazy var petGenre: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")?.resized(to: CGSize(width: 25, height: 25))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let keyvalueAge = KeyValueStackView(data: nil)
    let keyvalueWeight = KeyValueStackView(data: nil)
    let keyvalueHeight = KeyValueStackView(data: nil)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.customBlue
        prepareConstraint()
        
        petImages.backgroundColor = AppColors.bgColor
        petImages.addShadow()
        
        infoOutSideStackView.backgroundColor = AppColors.customWhite.withAlphaComponent(0.4)
        informationSideStackView.backgroundColor = AppColors.customWhite.withAlphaComponent(0.4)
        
        infoOutSideStackView.addShadow(
            shadowColor: AppColors.customDarkGray.cgColor,
            shadowOffset:CGSize(width: 5.0, height: 7.0),
            shadowOpacity: 0.7,
            shadowRadius: 4.0)
        
        informationSideStackView.addShadow(
            shadowColor: AppColors.customDarkGray.cgColor,
            shadowOffset:CGSize(width: 5.0, height: 7.0),
            shadowOpacity: 0.7,
            shadowRadius: 4.0)
        
        keyvalueAge.data = [("Age", presenter?.petData.birthDate?.calculateAge() ?? "6 month")]
        keyvalueHeight.data = [("Height", String(presenter?.petData.height ?? 1.2))]
        keyvalueWeight.data = [("Weight", String(presenter?.petData.weight ?? 1.2))]
    }
    
    private func prepareConstraint() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            view.addSubview(headerStackView)
            headerStackView.addArrangedSubview(petsNameLabel)
            headerStackView.addArrangedSubview(petGenre)
            headerStackView.addArrangedSubview(UIView())
            headerStackView.addArrangedSubview(closeButton)
            
            view.addSubview(petImages)
            view.addSubview(infoOutSideStackView)
            view.addSubview(informationSideStackView)
            
            infoOutSideStackView.addArrangedSubview(keyvalueAge)
            infoOutSideStackView.addArrangedSubview(keyvalueHeight)
            infoOutSideStackView.addArrangedSubview(keyvalueWeight)
            
            informationSideStackView.addArrangedSubview(specialInfo)
            
            NSLayoutConstraint.activate([
                headerStackView.topAnchor.constraint(equalTo: view.topAnchor,constant: 5.wPercent),
                headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5.wPercent),
                headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5.wPercent),
                
                petImages.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 5.wPercent),
                petImages.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.wPercent),
                petImages.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.wPercent),
                petImages.heightAnchor.constraint(equalToConstant: UIScreen.screenWidth / 1.5),
                
                infoOutSideStackView.topAnchor.constraint(equalTo: petImages.bottomAnchor, constant: 10.wPercent),
                infoOutSideStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.wPercent),
                infoOutSideStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.wPercent),
                
                informationSideStackView.topAnchor.constraint(equalTo: infoOutSideStackView.bottomAnchor, constant: 5.wPercent),
                informationSideStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.wPercent),
                informationSideStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.wPercent),
            ])
        }
    }
}

extension PetDetailViewController: PetDetailViewProtocol {
    func setupUI() { }
}
