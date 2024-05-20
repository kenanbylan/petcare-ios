//
//  AddViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 15.05.2024.
//
import UIKit

final class AddViewController: UIViewController {
    
    public var completion: ((String, String, Date) -> Void)?
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var titleField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ReminderView_detail_title".localized()
        return textfield
    }()
    
    private lazy var bodyField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ReminderView_detail_desc".localized()
        return textfield
    }()
    
    private let datePicker: UIDatePicker = {
        let dataPicker = UIDatePicker()
        return dataPicker
    }()
    
    private lazy var saveButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("ReminderView_detail_button".localized())
            .setBackgroundColor(AppColors.primaryColor)
            .setTitleColor(AppColors.customWhite)
        appbutton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        appbutton.layer.cornerRadius = 20
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        titleField.delegate = self
        bodyField.delegate = self
        saveButton.addTarget(self,
                             action: #selector(didTapSaveButton),
                             for: .touchUpInside)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(bodyField)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(saveButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stackView.frame = CGRect(x: 30,
                                 y: view.safeAreaInsets.top + 30,
                                 width: view.width - 60,
                                 height: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 60)
    }
    
    @objc func didTapSaveButton() {
        if let titleText = titleField.text, !titleText.isEmpty,
           let bodyText = bodyField.text, !bodyText.isEmpty {
            let targetDate = datePicker.date
            completion?(titleText, bodyText, targetDate)
        }
        dismiss(animated: true, completion: nil)
    }
}
