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
    
    let keyvalueAge = KeyValueStackView(data: nil)
    let keyvalueWeight = KeyValueStackView(data: nil)
    let keyvalueHeight = KeyValueStackView(data: nil)
    
    
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
        let label = CustomLabel(text: presenter?.petData.specialInfo, fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
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
            .withLayoutMargins(top: 10, left: 20, bottom: 10, right: 20)
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
        imageView.image = UIImage(named: presenter?.petTypeImage() ?? "dog")?.resized(to: CGSize(width: 25, height: 25))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var deletePetButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("PetDetailView_button".localized())
            .setBackgroundColor(AppColors.bgColor)
            .setTitleColor(AppColors.labelColor)
        appbutton.addTarget(self, action: #selector(petDeleteTapped), for: .touchUpInside)
        return appbutton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        prepareConstraint()
        prepareInfoView()
    }
    
    func prepareInfoView() {
        keyvalueAge.data = [("\("PetDetailView_age".localized()): ", presenter?.formattedAge() ?? "6 month")]
        keyvalueHeight.data = [("\("PetDetailView_height".localized()): ", presenter?.formattedHeight() ?? "1.2 cm")]
        keyvalueWeight.data = [("\("PetDetailView_weight".localized()): ", presenter?.formattedWeight() ?? "1.2 kg")]
    }
    
    func prepareViews() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_image.png")!)
        petImages.backgroundColor = AppColors.bgColor

        petImages.addShadow(shadowColor: AppColors.labelColor.cgColor, shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.4, shadowRadius: 3)
        infoOutSideStackView.backgroundColor = .secondarySystemBackground
        informationSideStackView.backgroundColor = .secondarySystemBackground
        
        infoOutSideStackView.addShadow(shadowColor: AppColors.customDarkGray.cgColor,
                                       shadowOffset:CGSize(width: 5.0, height: 7.0), shadowOpacity: 0.7, shadowRadius: 4.0)
        informationSideStackView.addShadow(shadowColor: AppColors.customDarkGray.cgColor,
                                           shadowOffset:CGSize(width: 5.0, height: 7.0), shadowOpacity: 0.7, shadowRadius: 4.0)
        
    }
    
    @objc func petDeleteTapped() {
        print("petDeleteTapped clicked!")
        guard let petName = presenter?.petData.name else { return }
        showAlertAction(title: "PetDetailView_error".localized(), message: "\(petName) \("PetDetailView_desc".localized())" , type: .actionSheet) {
            //
        }
    }
    
    private func prepareConstraint() {
        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(petsNameLabel)
        headerStackView.addArrangedSubview(petGenre)
        headerStackView.addArrangedSubview(UIView())
        headerStackView.addArrangedSubview(closeButton)
        
        view.addSubview(petImages)
        view.addSubview(infoOutSideStackView)
        view.addSubview(informationSideStackView)
        view.addSubview(deletePetButton)
        
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
            
            deletePetButton.topAnchor.constraint(equalTo: informationSideStackView.bottomAnchor, constant: 10.wPercent),
            deletePetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7.wPercent),
            deletePetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7.wPercent),
        ])
    }
}

extension PetDetailViewController: PetDetailViewProtocol {
    func setupUI() { }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        infoOutSideStackView.addShadow(shadowColor: AppColors.customDarkGray.cgColor,
                                       shadowOffset:CGSize(width: 5.0, height: 7.0),
                                       shadowOpacity: 0.7, shadowRadius: 4.0)
        informationSideStackView.addShadow(shadowColor: AppColors.customDarkGray.cgColor,
                                           shadowOffset:CGSize(width: 5.0, height: 7.0),
                                           shadowOpacity: 0.7, shadowRadius: 4.0)
        petImages.addShadow(shadowColor: AppColors.labelColor.cgColor,
                            shadowOffset: CGSize(width: 1, height: 2),
                            shadowOpacity: 0.4, shadowRadius: 3)
    }
    
}
