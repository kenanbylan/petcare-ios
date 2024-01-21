//
//  PetTypeController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.

import UIKit

protocol PetTypeViewProtocol: AnyObject {
    func prepareUI()
}

final class PetTypeController: UIViewController {
    var presenter: PetTypePresenterProtocol?
    
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
            .withShadow(color: AppColors.customDarkGray.cgColor, opacity: 0.4, offset: CGSize(width: 0, height: 4), radius: 4)
            .withLayoutMargins(top: 0, left: 12, bottom: 0, right: 12)
            .withBackgroundColor(AppColors.customBlue ?? .black)
            .build()
    }()
    
    private lazy var petTitle: CustomLabel = {
        let petTitle = CustomLabel(text: "Do you have?", fontSize: 14, fontType: .medium, textColor: AppColors.customWhite)
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var patiButton: PatiButton = {
        let patiButton = PatiButton()
        patiButton.delegate = self
        return patiButton
    }()
    
    
    //MARK: Variable's
    private var petTypeViews: [SelectPetView] = []
    private var selectItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTitleLabel()
        buildLayout()
        setNavigationBar()
    }
    
    private func setupPetTypes() {
        let petTypes = ["Cat", "Dog", "Bird", "Fish", "Rabbit","Other"]
        for type in petTypes {
            let petTypeView = SelectPetView()
            petTypeView.setText(type)
            petTypeView.delegate = self
            stackView.addArrangedSubview(petTypeView)
            petTypeViews.append(petTypeView)
        }
    }
    
    @objc func nextButtonClicked() {
        
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Hello my friend", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    private func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("Back", color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
}

extension PetTypeController: ViewCoding {
    func setupView() {
        scrollView.backgroundColor = AppColors.bgColor
        contentView.backgroundColor = AppColors.bgColor
        topStackView.backgroundColor = AppColors.customBlue
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
        setupPetTypes()
        
        contentView.addSubview(patiButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            
            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 24),
            topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 24),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -24),
            topStackView.heightAnchor.constraint(equalToConstant: UIScreen.screenWidth / 9),
            
            
            stackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 48),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            patiButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 60),
            patiButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}


extension PetTypeController: PetTypeViewProtocol, PetTypeDelegate, PatiButtonDelegate {
    func patiButtonClicked(_ sender: PatiButton) {
        if selectItem?.isEmpty == true {
            patiButton.isEnabled = false
        } else {
            patiButton.isEnabled = true
            presenter?.navigateToPetInfo()
        }
    }
    
    func didSelectPetType(_ petType: String) {
        selectItem = petType
        print("Selected Pet Type: \(petType)")
    }
    
    func prepareUI() {
        
    }
}
