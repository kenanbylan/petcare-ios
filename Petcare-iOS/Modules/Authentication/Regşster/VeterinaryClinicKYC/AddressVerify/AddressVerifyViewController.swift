//
//  AddressVerifyViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol AddressVerifyViewProtocol: AnyObject { }


final class AddressVerifyViewController: UIViewController {
    var presenter: AddressVerifyPresenterProtocol?
    
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
    
    private lazy var addressImageView: UIImageView = {
        let image = UIImageView()
        let myImage = UIImage(named: "happy-female")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        return image
    }()
    
    
    private lazy var clinicName: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_Name".localized()
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var clinicPhoneNumber: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_PHONE".localized()
        textfield.tintColor = AppColors.primaryColor
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    private lazy var cityTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_CITY".localized()
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var districtTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_DISTRICT".localized()
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var streetTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_Street".localized()
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var apartmentTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_No".localized()
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var houseTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "ADDRESS_VERIFY_apartmentNo".localized()
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment:.fill, distribution: .fill, spacing: 20)
        return stackView
    }()
    
    private lazy var appButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("ADDRESS_VERIFY_BUTTON_Continue".localized())
            .setTitleColor(AppColors.labelColor)
            .setImage(UIImage(named: "patiShape")?.resized(to: CGSize(width: 25, height: 25)))
            .setBackgroundColor(AppColors.bgColor2)
        appbutton.addTarget(self, action: #selector(appButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func appButtonClicked() {
        validateTextfield()
    }
    
    private func validateTextfield()  {
        do {
            let clinicName = try clinicName.validatedText(validationType: .requiredField(field: "ADDRESS_VERIFY_clinic_name".localized()))
            
            let clinicPhone = try clinicPhoneNumber.validatedText(validationType: .phone)
            
            let city = try cityTextField.validatedText(validationType: .requiredField(field: "ADDRESS_VERIFY_city_name".localized()))
            let district = try districtTextField.validatedText(validationType: .requiredField(field: "ADDRESS_VERIFY_disctirct_name".localized()))
            let street = try streetTextField.validatedText(validationType: .requiredField(field: "ADDRESS_VERIFY_street_name".localized()))
            
            let no = try apartmentTextField.validatedText(validationType: .number)
            
            let mesken = try houseTextField.validatedText(validationType: .requiredField(field: "ADDRESS_VERIFY_no_mesken".localized()))
            
            let address = VetAddress(clinicName: clinicName, clinicCity: city, clinicDiscrict: district, clinicStreet: street, clinicNo: no, apartmentNo: mesken)
            
            presenter?.saveVetAddressData(address: address)
            presenter?.navigateDocumentVerify()
            
        } catch (let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
}

extension AddressVerifyViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = AppColors.bgColor
        setupKeyboardDismissRecognizer()
        self.title = "ADDRESS_VERIFY_Header".localized()
        addressImageView.image = UIImage(named: "clinic-address")
    }
    
    func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        let hConst = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConst.isActive = true
        hConst.priority = UILayoutPriority(50)
        
        contentView.addSubview(addressImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(appButton)
        
        stackView.addArrangedSubview(clinicName)
        stackView.addArrangedSubview(clinicPhoneNumber)
        stackView.addArrangedSubview(cityTextField)
        stackView.addArrangedSubview(districtTextField)
        stackView.addArrangedSubview(streetTextField)
        stackView.addArrangedSubview(apartmentTextField)
        stackView.addArrangedSubview(houseTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView Constraints
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // ContentView Constraints
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: 30),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Address ImageView Constraints
            addressImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            addressImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addressImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            addressImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // StackView Constraints
            stackView.topAnchor.constraint(equalTo: addressImageView.bottomAnchor, constant: 24),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.wPercent),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.wPercent),
            
            // AppButton Constaints
            appButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10.wPercent),
            appButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 5.wPercent),
            appButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -5.wPercent),
        ])
    }
}

extension AddressVerifyViewController {
    
    @objc func keyboardWillAppear(notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardHeight = keyboardFrame.height / 3
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // ScrollView'in içeriğini klavyenin üstüne doğru kaydır
        var aRect = self.view.frame
        aRect.size.height -= keyboardHeight
        
        //MARK: Aktif text field'i kontrol et
        if !aRect.contains(houseTextField.frame.origin) {
            scrollView.scrollRectToVisible(houseTextField.frame, animated: true)
        }
    }
    
    //MARK: Klavye kapanışını takip eden işlem
    @objc func keyboardWillDisappear(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
