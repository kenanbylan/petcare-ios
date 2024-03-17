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
        let label = CustomLabel(text: "Bobo, Holosko", fontSize: 21, fontType: .bold, textColor: AppColors.labelColor)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter the email address with your account and we'll send an email with confirmation to reset your password"
        label.numberOfLines = 3
        label.tintColor = AppColors.labelColor
        label.font = AppFonts.medium.font(size: 14)
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var petImages: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "info-cat")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        view.backgroundColor = AppColors.customBlue
        prepareConstraint()
        
        petImages.backgroundColor = AppColors.bgColor
        petImages.addShadow()
        
        infoOutSideStackView.backgroundColor = AppColors.customWhite.withAlphaComponent(0.4)
        infoOutSideStackView.addShadow(
            shadowColor: AppColors.customDarkGray.cgColor,
            shadowOffset:CGSize(width: 5.0, height: 7.0),
            shadowOpacity: 0.7,
            shadowRadius: 4.0)

        keyvalueAge.data = [("Age", "6 months")]
        keyvalueHeight.data = [("Height", "40 CM") ]
        keyvalueWeight.data = [("Weight", "4 Kg 2 gr")]
    }
    
    private func prepareConstraint() {
        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(petsNameLabel)
        headerStackView.addArrangedSubview(petGenre)
        headerStackView.addArrangedSubview(UIView())
        headerStackView.addArrangedSubview(closeButton)
        
        view.addSubview(petImages)
        view.addSubview(infoOutSideStackView)
        
        infoOutSideStackView.addArrangedSubview(keyvalueAge)
        infoOutSideStackView.addArrangedSubview(keyvalueHeight)
        infoOutSideStackView.addArrangedSubview(keyvalueWeight)
    
        
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
            
        ])
    }
}

extension PetDetailViewController: PetDetailViewProtocol {
    func setupUI() { }
}

struct MyTestVsC_Previews: PreviewProvider {
    static var previews: some View {
        PetDetailViewController().showPreview()
    }
}
