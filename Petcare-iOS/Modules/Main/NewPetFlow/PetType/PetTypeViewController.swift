//
//  PetTypeController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.12.2023.

import UIKit
import SwiftUI
import Combine

protocol PetTypeViewProtocol: AnyObject {
    func prepareUI()
}

final class PetTypeViewController: BaseViewController {
    var presenter: PetTypePresenterProtocol?
    private var cancellables = Set<AnyCancellable>()
    
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
    
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical,alignment: .fill,distribution: .equalSpacing,spacing: 24)
        return stackView
    }()
    
    private lazy var patiButton: AppButton = {
        let appbutton = AppButton.build()
            .setDelegate(self)
            .setTitle("İlerle")
            .setImage(UIImage(named: "pati")?.resized(to: CGSize(width: 24, height: 24)))
            .setBackgroundColor(AppColors.customBlue)
        return appbutton
    }()
    
    //MARK: Variable's
    var petTypeViews: [SelectPetView] = []
    @Published private var selectItem: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTitleLabel()
        buildLayout()
        setNavigationBar()
        patiButton.isEnabled = false
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
    
    @objc func nextButtonClicked() { }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Hello my friend", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    private func setNavigationBar() {
        navigationItem.setCustomBackButtonTitle("Back", color: AppColors.primaryColor)
        navigationController?.navigationBar.tintColor = AppColors.primaryColor
    }
    
    private func setupBindings() {
        $selectItem
            .map { $0 != nil && !$0!.isEmpty } // Select item var mı ve boş değil mi?
            .assign(to: \.isEnabled, on: patiButton)
            .store(in: &cancellables)
    }
}

extension PetTypeViewController: ViewCoding {
    
    func setupView() {
        scrollView.backgroundColor = AppColors.bgColor
        contentView.backgroundColor = AppColors.customRed
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
        setupPetTypes()
        
        print("width: ", view.frame.width)
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


extension PetTypeViewController: PetTypeViewProtocol, PetTypeDelegate, AppButtonDelegate {
    func patiButtonClicked(_ sender: AppButton) {
        print("clicked patiButtonClicked")
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
    
    func prepareUI() { }
    
}


struct PetTypeViewController_Previews: PreviewProvider {
    static var previews: some View {
        PetTypeViewController().showPreview()
    }
}
