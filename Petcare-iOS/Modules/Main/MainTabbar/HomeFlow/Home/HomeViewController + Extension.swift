//
//  HomeViewController + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 20.05.2024.
//

import UIKit

//MARK: HomeViewController Constraints
extension HomeViewController {
    func setupConstraints() {
        view.backgroundColor = AppColors.bgColor
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        guard let sliderView = sliderView else { return }
        contentView.addSubview(sliderView)
        
        contentView.addSubview(managePetsSectionLabel)
        contentView.addSubview(collectionView)
        contentView.addSubview(secondaryTitleStackView)
        contentView.addSubview(titleStackView)
        contentView.addSubview(nearbyView)
        contentView.addSubview(reminderView)
        contentView.addSubview(upComingVeterinaryLabel)
        contentView.addSubview(upComingVeterinaryView)
        
        titleStackView.addArrangedSubview(nearbyVeterinaryLabel)
        titleStackView.addArrangedSubview(UIView())
        titleStackView.addArrangedSubview(nearbySeeAllButton)
        
        secondaryTitleStackView.addArrangedSubview(reminderVeterinaryLabel)
        secondaryTitleStackView.addArrangedSubview(UIView())
        secondaryTitleStackView.addArrangedSubview(reminderButton)
        
        appointmentStackView.addArrangedSubview(veterinaryAppointmentLabel)
        appointmentStackView.addArrangedSubview(UIView())
        appointmentStackView.addArrangedSubview(appointmentListButton)
        
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -50),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            sliderView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 24),
            sliderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            sliderView.heightAnchor.constraint(equalToConstant: 25.hPercent),
            
            managePetsSectionLabel.topAnchor.constraint(equalTo: sliderView.bottomAnchor, constant: 12),
            managePetsSectionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            managePetsSectionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: managePetsSectionLabel.bottomAnchor,constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.width / 3),
            
            secondaryTitleStackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor,constant: 12),
            secondaryTitleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            secondaryTitleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            reminderView.topAnchor.constraint(equalTo: secondaryTitleStackView.bottomAnchor, constant: 12),
            reminderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            reminderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            titleStackView.topAnchor.constraint(equalTo: reminderView.bottomAnchor, constant: 12),
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            nearbyView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 12),
            nearbyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nearbyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nearbyView.heightAnchor.constraint(equalToConstant: view.frame.width / 5),
            
            upComingVeterinaryLabel.topAnchor.constraint(equalTo: nearbyView.bottomAnchor, constant: 12),
            upComingVeterinaryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            upComingVeterinaryView.topAnchor.constraint(equalTo: upComingVeterinaryLabel.bottomAnchor, constant: 12),
            upComingVeterinaryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            upComingVeterinaryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            upComingVeterinaryView.heightAnchor.constraint(equalToConstant: view.frame.width / 4),
        ])
    }
}
