//
//  CalendarViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 5.11.2023.
//

import UIKit
import SwiftUI

protocol CalendarViewProtocol: AnyObject { }

final class CalendarViewController: BaseViewController {
    var presenter: CalendarPresenterProtocol?
    private var sliderView: SlideView?
    private var sliderData = [SlideView.SlideData]()
    
    private lazy var upComingVeterinaryLabel: CustomLabel = {
        let upcoming = CustomLabel(text: "Nearby Veterinary", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var upComingRezervation: CustomLabel = {
        let upcoming = CustomLabel(text: "Upcoming Rezervation", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        return upcoming
    }()
    
    private lazy var seeAllButton: SeeAllButton = {
        return SeeAllButtonBuilder()
            .withAction {
                  self.presenter?.navigateToNearbyList()
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
    
    private lazy var upComingVeterinaryView: UpcomingVeterinary = {
        let view = UpcomingVeterinary()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addShadow(shadowColor: AppColors.bgColor.cgColor)
        return  view
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
        view.addSubview(upComingVeterinaryView)
        
        titleStackView.addArrangedSubview(upComingVeterinaryLabel)
        titleStackView.addArrangedSubview(UIView())
        titleStackView.addArrangedSubview(seeAllButton)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sliderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sliderView.heightAnchor.constraint(equalToConstant: 25.hPercent),
            
            titleStackView.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 16),
            titleStackView.leadingAnchor.constraint(equalTo: sliderView.leadingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: sliderView.trailingAnchor, constant: -16),
            
            upComingVeterinaryView.topAnchor.constraint(equalTo: upComingVeterinaryLabel.bottomAnchor, constant: 16),
            upComingVeterinaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            upComingVeterinaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            upComingVeterinaryView.heightAnchor.constraint(equalToConstant: 100),
            
            
        ])
    }
}

extension CalendarViewController: SlideViewProtocol {
    func currentPageDidChange(to page: Int) {
        UIView.animate(withDuration: 0.7) {
            
        }
    }
}
