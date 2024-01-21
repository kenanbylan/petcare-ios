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

    //MARK: UI Properties
    private let scrollView: UIScrollView = {
        let srollView = UIScrollView()
        srollView.translatesAutoresizingMaskIntoConstraints = false
        return srollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: AllStackView
    fileprivate lazy var allStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    //MARK: HStackView
    fileprivate lazy var hStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
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
    
    private lazy var patiButton: PatiButton = {
        let patiButton = PatiButton()
        patiButton.delegate = self
        return patiButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        
        self.dateBirthTextfield.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        let datePicker = self.dateBirthTextfield.inputView as? UIDatePicker
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
    
        if let selectedDate = datePicker?.date {
            self.dateBirthTextfield.text = dateformatter.string(from: selectedDate)
        }
        self.dateBirthTextfield.resignFirstResponder()
    }
}

extension PetInfoViewController: PetInfoViewProtocol, PatiButtonDelegate {
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Almost Done", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    func patiButtonClicked(_ sender: PatiButton) {
        presenter?.navigateSelectPetImage()
    }
}

extension PetInfoViewController: ViewCoding {
    func setupView() { }
    
    func setupHierarchy() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(allStackView)
        self.contentView.addSubview(patiButton)
        
        let views: [UIView] = [genderSegmentedControl,petsNameLabel,petsNameTextfield,dateBirthLabel,dateBirthTextfield,hStackView]
        for i in views { allStackView.addArrangedSubview(i) }
        
        hStackView.addArrangedSubview(weightTextField)
        hStackView.addArrangedSubview(heightTextField)
    }
    
    func setupConstraints() {
        scrollView.applyConstraints( builder: { builder in
            builder.setTargetView(self.view)
                .addAnchor(.top, .left, .right, .bottom)
                .addConstant(20)
                .build()
        })
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: self.scrollView.heightAnchor),
            
            allStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            allStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            allStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            patiButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -200),
            patiButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
}
