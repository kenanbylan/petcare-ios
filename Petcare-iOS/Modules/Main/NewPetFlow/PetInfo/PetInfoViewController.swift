//
//  PetInfoViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 3.01.2024.
//

import UIKit
import SwiftUI

protocol PetInfoViewProtocol: AnyObject {
    func prepareUI()
}

final class PetInfoViewController: BaseViewController {
    var presenter: PetInfoPresenterProtocol?

    //MARK: UI Properties
    private let scrollView: UIScrollView = {
        let srollView = UIScrollView()
        srollView.showsVerticalScrollIndicator = false
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

    private lazy var petsNameTextfield: CustomTextField = {
        let textfield = CustomTextField(viewModel: .init(type: .name, placeholder: "Pet name"))
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var dateBirthTextfield: MyTextField = {
        let textfield = MyTextField()
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
        let textfield = CustomTextField(viewModel: .init(type: .numberInt, placeholder: "Weight (kg)"))
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var heightTextField: CustomTextField = {
        let textfield = CustomTextField(viewModel: .init(type: .numberInt, placeholder: "Weight (kg)"))
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    //MARK: BUİLDER PATTERN
    private lazy var appButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("Continue")
            .setImage(UIImage(named: "coffee")?.resized(to: CGSize(width: 25, height: 25)))
            .setBackgroundColor(AppColors.primaryColor)
        return appbutton
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        dateBirthTextfield.delegate = self
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
    
    override func keyboardWillShow(with height: CGFloat) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }
    
    override func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

extension PetInfoViewController: UITextFieldDelegate {
    
}

extension PetInfoViewController: PetInfoViewProtocol {
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Almost Done", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
    func patiButtonClicked(_ sender: AppButton) {
        presenter?.navigateSelectPetImage()
    }
}
extension PetInfoViewController: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(allStackView)
        self.contentView.addSubview(appButton)
        
        let views: [UIView] = [genderSegmentedControl,petsNameTextfield,dateBirthTextfield,hStackView]
        for i in views { allStackView.addArrangedSubview(i) }
    
        hStackView.addArrangedSubview(weightTextField)
        hStackView.addArrangedSubview(heightTextField)
        
        let scrollViewHeight = scrollView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height)
        scrollViewHeight.priority = .required - 1
        scrollViewHeight.isActive = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: scrollView.contentSize.height),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            allStackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 24),
            allStackView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5.wPercent),
            allStackView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5.wPercent),
            allStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),

            appButton.topAnchor.constraint(equalTo: self.allStackView.bottomAnchor, constant: 10.wPercent),
            appButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 5.wPercent),
            appButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -5.wPercent),
        ])
        
    }
}

struct MyTestVC_Previews: PreviewProvider {
    static var previews: some View {
        PetInfoViewController().showPreview()
    }
}
