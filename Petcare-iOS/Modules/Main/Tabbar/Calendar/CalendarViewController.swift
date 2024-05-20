//
//  CalendarViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import SwiftUI
import MapKit

protocol CalendarViewProtocol: AnyObject { }

final class CalendarViewController: BaseViewController {
    var presenter: CalendarPresenterProtocol?
    private var sliderView: SlideView?
    private var sliderData = [SlideView.SlideData]()
    
    private lazy var upComingVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Nearby Veterinary", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var reminderVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "My Reminder list", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var latestReminderInfoLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "My Latest reminder", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var upComingRezervation: CustomLabel = {
        let upcoming = CustomLabel(text: "Upcoming Rezervation", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var seeAllButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToNearbyList(onlyShow: false)
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
    }()
    
    private lazy var reminderButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                self.presenter?.navigateToReminder()
            }
            .withOriginalImage(UIImage(named: "pati")!)
            .withTargetHeight(30)
            .build()
    }()
    
    
    private lazy var topStackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withCornerRadius(12)
            .withAxis(.horizontal)
            .withLayoutMargins(top: 0, left: 12, bottom: 0, right: 12)
            .withBackgroundColor(AppColors.customBlue ?? .black)
            .build()
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var secondaryTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution  = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nearbyView: NearbyVetView = {
        let view = NearbyVetView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        sliderView = SlideView(pages: 3, delegate: self)
        sliderData.append(.init(image: UIImage(named: "info-host"), text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
        sliderData.append(.init(image: UIImage(named: "info-dog"),text: "elit"))
        sliderData.append(.init(image: UIImage(named: "info-cat"), text: "consectetur adipiscing elit"))
        
        prepareUI()
        sliderView?.configureView(with: sliderData)
        
        setupTitle()
        
        let rezervation = UIBarButtonItem(image: UIImage(systemName: "plus.circle.fill"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(rezervationTapped))
        rezervation.tintColor = AppColors.primaryColor
        navigationItem.rightBarButtonItem = rezervation
    }
    
    @objc func rezervationTapped() {
        presenter?.navigateToNearbyList(onlyShow: true)
    }
    
    private func setupTitle() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText:"Rezervation", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sliderView?.configureView(with: sliderData)
    }
    
    func prepareUI() {
        setupConstraints()
        view.backgroundColor = AppColors.bgColor
    }
    
    private func setupConstraints() {
        guard let sliderView = sliderView else { return }
        view.addSubview(sliderView)
        view.addSubview(titleStackView)
        view.addSubview(nearbyView)
        view.addSubview(secondaryTitleStackView)
        
        titleStackView.addArrangedSubview(upComingVeterinaryLabel)
        titleStackView.addArrangedSubview(UIView())
        titleStackView.addArrangedSubview(seeAllButton)
        
        secondaryTitleStackView.addArrangedSubview(latestReminderInfoLabel)
        secondaryTitleStackView.addArrangedSubview(UIView())
        secondaryTitleStackView.addArrangedSubview(reminderButton)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sliderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sliderView.heightAnchor.constraint(equalToConstant: 25.hPercent),
            
            titleStackView.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 16),
            titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            nearbyView.topAnchor.constraint(equalTo: upComingVeterinaryLabel.bottomAnchor, constant: 16),
            nearbyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nearbyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nearbyView.heightAnchor.constraint(equalToConstant: 100),
            
            secondaryTitleStackView.topAnchor.constraint(equalTo: nearbyView.bottomAnchor, constant: 16),
            secondaryTitleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            secondaryTitleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

extension CalendarViewController: SlideViewProtocol {
    func currentPageDidChange(to page: Int) {}
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        nearbyView.addShadow(shadowColor: AppColors.bgColor.cgColor)
    }
}
