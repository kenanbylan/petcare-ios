//
//  PetInfoViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit

protocol PetInfoViewProtocol: AnyObject {
    func prepareUI()
}

final class PetInfoViewController: UIViewController {
    var presenter: PetInfoPresenterProtocol?

    
    //MARK: AllStackView
    fileprivate lazy var allStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: Pet name properties
    private lazy var petsNameLabel: CustomLabel = {
        let label = CustomLabel(text: "Pets name", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var petsNameTextfield: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "entery name :)"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    //MARK: Birth of date properties
    private lazy var dateBirthLabel: CustomLabel = {
        let label = CustomLabel(text: "Pets Date of birth", fontSize: 14, fontType: .medium, textColor: AppColors.labelColor)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateBirthTextfield: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "4 Jan 2020"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    
    let genderSegmentedControl: UISegmentedControl = {
        let items = ["Male", "Female"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0 // Default to Male
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let weightSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0 
        slider.maximumValue = 150
        slider.value = 70 // Default to 70 kg
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    let heightSlider: UISlider = {
        let slider = UISlider()
        slider.largeContentTitle = "Height"
        slider.minimumValue = 100
        slider.maximumValue = 220
        slider.value = 170 // Default to 170 cm
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    
    private lazy var weightTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Weight (kg)"
        textfield.tintColor = AppColors.primaryColor
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    private lazy var heightTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "Height (cm)"
        textfield.tintColor = AppColors.primaryColor
        textfield.keyboardType = .numberPad
        return textfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        
        self.dateBirthTextfield.setInputViewDatePicker(targer: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        if let datePicker = self.dateBirthTextfield.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .medium
            self.dateBirthTextfield.text = dateformatter.string(from: datePicker.date)
        }
        self.dateBirthTextfield.resignFirstResponder()
    }
}

extension PetInfoViewController: PetInfoViewProtocol {
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Almost Done", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}

extension PetInfoViewController: ViewCoding {
    func setupView() {
        view.addSubview(petsNameTextfield)
        view.addSubview(allStackView)
    }
    
    func setupHierarchy() {
        allStackView.addArrangedSubview(petsNameLabel)
        allStackView.addArrangedSubview(petsNameTextfield)
        allStackView.addArrangedSubview(dateBirthLabel)
        allStackView.addArrangedSubview(dateBirthTextfield)
        allStackView.addArrangedSubview(genderSegmentedControl)
        
        allStackView.addArrangedSubview(weightSlider)
        allStackView.addArrangedSubview(heightSlider)
        allStackView.addArrangedSubview(weightTextField)
        allStackView.addArrangedSubview(heightTextField)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
//            dateBirthTextfield.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 30),
//            dateBirthTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
//            dateBirthTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
//            dateBirthTextfield.heightAnchor.constraint(equalToConstant: 44)
            
            genderSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            genderSegmentedControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            allStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 24),
            allStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            allStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
        
        ])
    }
}
