//
//  PetTypeController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.

import UIKit
import SwiftUI

protocol PetTypeViewProtocol: AnyObject {
    func prepareUI()
}

protocol PetTypeViewDelegate: AnyObject {
    func didSelectPet()
}

final class PetTypeViewController: UIViewController {
    var presenter: PetTypePresenterProtocol?
    weak var delegate: PetTypeViewDelegate?
    
    //MARK: UI Properties
    private let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        return sView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topStackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withCornerRadius(12)
            .withAxis(.horizontal)
            .withLayoutMargins(top: 0, left: 12, bottom: 0, right: 12)
            .withBackgroundColor(AppColors.customBlue ?? .black)
            .build()
    }()
    
    private lazy var petTitle: CustomLabel = {
        let petTitle = CustomLabel(text: "PetTypeView_header".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.customWhite)
        return petTitle
    }()
    
    private lazy var arrowIcon: UIImageView = {
        let image = UIImageView()
        let myImage = UIImage(named: "arrow_down")
        let resizedImage = myImage!.resized(to: CGSize(width: 12, height: 12))
        image.image = resizedImage
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 24)
        return stackView
    }()
    
    private lazy var patiButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("PetTypeView_button".localized())
            .setImage(UIImage(named: "pati")?.withRenderingMode(.alwaysTemplate).resized(to: CGSize(width: 25, height: 25)))
            .setBackgroundColor(AppColors.primaryColor)
            .setTitleColor(AppColors.customWhite)
        appbutton.isEnabled = false
        appbutton.addTarget(self, action: #selector(patiButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    //MARK: Variable's
    var petTypeViews: [SelectPetView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTitleLabel()
        buildLayout()
        setNavigationBar()
        setupPetTypes()
    }
    
    //MARK: - Pet Types Setup
    private func setupPetTypes() {
        for type in presenter?.petTypes ?? [] {
            let petTypeView = SelectPetView()
            petTypeView.setText(type)
            petTypeView.delegate = self
            stackView.addArrangedSubview(petTypeView)
            petTypeViews.append(petTypeView)
        }
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter!.title, fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    
    private func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("PetTypeView_back".localized(), color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
}

extension PetTypeViewController: PetTypeViewProtocol {
    func prepareUI() { }
}

//MARK: - Select Pet View Delegate
extension PetTypeViewController: SelectPetViewDelegate {
    func didSelect(_ view: SelectPetView) {
        presenter?.selectPet = view.petType
        
        print("selected Pet :", presenter?.selectPet ?? "")
        let isAnyItemSelected = petTypeViews.contains { $0.isSelected }
        delegate?.didSelectPet()
        patiButton.isEnabled = isAnyItemSelected
    }
}

//MARK: - Button Action
extension PetTypeViewController {
    @objc func patiButtonClicked() {
        print("Button clicked!")
        presenter?.navigateToPetInfo()
    }
}

extension PetTypeViewController: ViewCoding {
    func setupView() {
        scrollView.backgroundColor = AppColors.bgColor
        topStackView.backgroundColor = AppColors.customBlue
        topStackView.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
    
    func setupHierarchy() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        contentView.addSubview(topStackView)
        
        topStackView.addArrangedSubview(petTitle)
        topStackView.addArrangedSubview(UIView())
        topStackView.addArrangedSubview(arrowIcon)
        
        contentView.addSubview(stackView)
        contentView.addSubview(patiButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor,constant: 100),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5.wPercent),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5.wPercent),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5.wPercent),
            topStackView.heightAnchor.constraint(equalToConstant: 12.wPercent),
            
            stackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10.wPercent),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.wPercent),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.wPercent),
            
            patiButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15.wPercent),
            patiButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 5.wPercent),
            patiButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -5.wPercent),
            patiButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}

extension PetTypeViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        topStackView.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
}
