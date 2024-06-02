//
//  DateListInfoDetailViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 14.05.2024.

import UIKit

protocol DateListInfoDetailViewProtocol: AnyObject {
    
}


final class DateListInfoDetailViewController: UIViewController {
    var presenter: DateListInfoDetailPresenterProtocol!
    
    //MARK: Variable's
    var timeSelectViews: [MultiSelectView] = []
    
    private lazy var topStackView: CustomStackView = {
        return CustomStackViewBuilder()
            .withCornerRadius(12)
            .withAxis(.horizontal)
            .withLayoutMargins(top: 0, left: 12, bottom: 0, right: 12)
            .withBackgroundColor(AppColors.primaryColor ?? .black)
            .build()
    }()
    
    private lazy var workingTitle: CustomLabel = {
        let petTitle = CustomLabel(text: "DateListInfoDetailView_header".localized(), fontSize: 14, fontType: .medium, textColor: AppColors.customWhite)
        return petTitle
    }()
    
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment: .fill, distribution: .equalSpacing, spacing: 24)
        return stackView
    }()
    
    private lazy var doneButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("DateListInfoDetailView_button".localized())
            .setImage(UIImage(named: "pati")?.withRenderingMode(.alwaysTemplate).resized(to: CGSize(width: 25, height: 25)))
            .setBackgroundColor(AppColors.primaryColor)
            .setTitleColor(AppColors.customWhite)
        appbutton.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
        prepareMultiSelectView(selections: presenter.dateTimeList)
        
        view.backgroundColor = AppColors.bgColor
        view.addSubview(topStackView)
        view.addSubview(stackView)
        view.addSubview(doneButton)
        
        topStackView.addArrangedSubview(workingTitle)
        
        setupConstraints()
        prepareTitleLabel()
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "DateListInfoDetailView_title".localized(), fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension DateListInfoDetailViewController: DateListInfoDetailViewProtocol {
    func prepareMultiSelectView(selections: [String: Bool]) {
        for (timeSlot, isSelected) in selections {
            let timeSelectView = MultiSelectView()
            timeSelectView.setText(timeSlot)
            timeSelectView.delegate = self
            timeSelectView.isSelected = isSelected // Backendden gelen seçim durumunu ayarla
            timeSelectViews.append(timeSelectView)
            stackView.addArrangedSubview(timeSelectView)
        }
    }
}

//MARK: - Button Action
extension DateListInfoDetailViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5.wPercent),
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5.wPercent),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5.wPercent),
            topStackView.heightAnchor.constraint(equalToConstant: 12.wPercent),
            
            stackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 5.wPercent),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5.wPercent),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5.wPercent),
            
            doneButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10.wPercent),
            doneButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5.wPercent),
            doneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.wPercent),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func doneButtonClicked() {
        var selectedTimeSlots: [String: Bool] = [:]
        for timeSelectView in timeSelectViews {
            selectedTimeSlots[timeSelectView.itemTitle] = timeSelectView.isSelected
        }
        
        // Backend'e seçilen zaman dilimlerini gönder
        print("Selected time slots: \(selectedTimeSlots)")
    }
    
}

extension DateListInfoDetailViewController: MultiSelectViewDelegate {
    func didSelect(_ view: MultiSelectView, isSelected: Bool) {
        print("Time slot \(view.itemTitle) selected: \(isSelected)")
    }
}

