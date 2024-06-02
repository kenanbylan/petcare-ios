//
//  VeterinaryDetailViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 11.03.2024.
//

import Foundation
import UIKit
import SwiftUI

protocol VeterinaryDetailViewProtocol: AnyObject, CustomAlert {
    func updateView()
}

final class VeterinaryDetailViewController: UIViewController, UIScrollViewDelegate {
    var presenter: VeterinaryDetailPresenterProtocol!
    
    //MARK: UI Properties
    private let scrollView: UIScrollView = {
        let sView = UIScrollView()
        sView.translatesAutoresizingMaskIntoConstraints = false
        sView.contentInsetAdjustmentBehavior = .never
        sView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        sView.showsVerticalScrollIndicator = false
        return sView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerImageView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "VeterinaryDetailView_select_pet".localized()
        textfield.tintColor = AppColors.primaryColor
        textfield.isShouldChangeCharactersIn()
        return textfield
    }()
    
    private lazy var availableDay: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "VeterinaryDetailView_select_days".localized()
        textfield.tintColor = AppColors.primaryColor
        textfield.isShouldChangeCharactersIn()
        return textfield
    }()
    
    //TODO: READ ONLY
    private lazy var availableHour: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "VeterinaryDetailView_select_hours".localized()
        textfield.tintColor = AppColors.primaryColor
        textfield.isShouldChangeCharactersIn()
        return textfield
    }()
    
    private lazy var doctorImage: UIImageView = {
        let image = UIImageView()
        let myImage = UIImage(named: "happy-female")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        return image
    }()
    
    private let textLabel: CustomLabel = {
        let label = CustomLabel(text: "Kucukyali", fontSize: 21, fontType: .semibold, textColor: AppColors.primaryColor)
        return label
    }()
    
    private let infoLabel: CustomLabel = {
        let label = CustomLabel(text: "VeterinaryDetailView_info_label".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return label
    }()
    
    private lazy var phoneLabel: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("0531 584 7699", for: .normal)
        button.titleLabel?.font = AppFonts.regular.font(size: 14)
        button.setImage(UIImage(systemName: "phone.circle"), for: .normal)
        button.tintColor = AppColors.labelColor // Image ve title rengi olarak primaryColor kullanılıyor.
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var locationInfo: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Istanbul, Turkey", for: .normal)
        button.titleLabel?.font = AppFonts.regular.font(size: 14)
        button.setImage(UIImage(systemName: "location.circle"), for: .normal)
        button.tintColor = AppColors.primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var conversationTextView: CustomTextView = {
        return CustomTextView.Builder()
            .text("")
            .textColor(AppColors.labelColor)
            .font(AppFonts.medium.font(size: 14))
            .shadowOffset(CGSize(width: 2, height: 2))
            .cornerRadius(12)
            .borderWidth(2)
            .borderColor(AppColors.borderColor)
            .height(UIScreen.screenWidth / 2)
            .build()
    }()
    
    private lazy var horizontalStackView: CustomStackView = {
        let stackView = CustomStackView(axis: .horizontal, alignment: .fill, distribution: .fill)
        return stackView
    }()
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment:.fill, distribution: .fill, spacing: 20)
        return stackView
    }()
    
    private lazy var doneButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("VeterinaryDetailView_button".localized())
            .setTitleColor(AppColors.customWhite)
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        prepareTitleLabel()
        buildLayout()
        scrollView.delegate = self
        doctorImage.image = UIImage(named: "happy-female")
        
        ///MARK: Kullanıcı seçebileceği seçeneklerin listesi
        let availableDays = ["Pazartesi", "Çarşamba", "Perşembe"]
        let availableHours = ["09.00 - 11.00", "11.00 - 13.00","15.00 - 17.00"]
        
        availableDay.setInputViewBottomSheet(options: availableDays, target: self, selector: #selector(selectDays(_:)),title: "VeterinaryDetailView_select_days".localized())
        availableHour.setInputViewBottomSheet(options: availableHours, target: self, selector: #selector(selectHours(_:)),title: "VeterinaryDetailView_select_hours".localized())
        
        setupKeyboardDismissRecognizer()
        prepareGetData()
    }
    
    private func prepareGetData() {
        textLabel.text = presenter.getClinicName()
        locationInfo.setTitle(presenter.getClinicAddress(), for: .normal)
        phoneLabel.setTitle(presenter.getClinicPhone(), for: .normal)
    }
    
    @objc
    func handleOptionSelection(_ selectedOption: String) {
        textField.text = selectedOption
    }
    
    @objc
    func selectDays(_ selectedOption: String) {
        availableDay.text = selectedOption
    }
    
    @objc
    func selectHours(_ selectedOption: String) {
        availableHour.text = selectedOption
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "VeterinaryDetailView_select_book".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    @objc
    private func buttonTapped() {
        // presenter.
    }
}

extension VeterinaryDetailViewController: VeterinaryDetailViewProtocol {
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            self?.textField.setInputViewBottomSheet(options: self?.presenter.petNames() ?? [] , target: self, selector: #selector(self?.handleOptionSelection(_:)),title: "VeterinaryDetailView_select_pet".localized())
        }
    }
}

extension VeterinaryDetailViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = AppColors.bgColor
        contentView.layer.cornerRadius = 20
        contentView.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(headerImageView)
        headerImageView.addSubview(doctorImage)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        let views: [UIView] = [textLabel, horizontalStackView, textField, availableDay, availableHour , infoLabel, conversationTextView,doneButton ]
        for view in views {
            stackView.addArrangedSubview(view)
        }
        
        horizontalStackView.addArrangedSubview(phoneLabel)
        horizontalStackView.addArrangedSubview(UIView())
        horizontalStackView.addArrangedSubview(locationInfo)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let headerImageViewBottom : NSLayoutConstraint!
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        headerImageViewBottom = self.headerImageView.bottomAnchor.constraint(equalTo: self.contentView.topAnchor, constant: -20)
        headerImageViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerImageViewBottom.isActive = true
        
        
        let imageViewTopConstraint: NSLayoutConstraint!
        NSLayoutConstraint.activate([
            doctorImage.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor),
            doctorImage.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor),
            doctorImage.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor)
        ])
        
        imageViewTopConstraint = self.doctorImage.topAnchor.constraint(equalTo: self.view.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 250),
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -UIScreen.screenHeight / 6),
            stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        ])
    }
}

extension VeterinaryDetailViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        contentView.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
}
