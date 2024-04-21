//
//  AddressVerifyViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 31.03.2024.
//

import UIKit

protocol AddressVerifyViewProtocol: AnyObject {
    
}

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
    
    private lazy var cityTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Select City"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var districtTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Select District"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var streetTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Street "
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var apartmentTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = " No"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var houseTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "House No"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var stackView: CustomStackView = {
        let stackView = CustomStackView(axis: .vertical, alignment:.fill, distribution: .fill, spacing: 20)
        return stackView
    }()
    
    private lazy var appButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("Continue")
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
        presenter?.navigateDocumentVerify()
    }
    
}

extension AddressVerifyViewController: ViewCoding {
    func setupView() {
        view.backgroundColor = AppColors.bgColor
        setupKeyboardDismissRecognizer()
        self.title = "Address Verify"
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
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
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
            
            
            appButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 10.wPercent),
            appButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 5.wPercent),
            appButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -5.wPercent),
        ])
    }
}

extension AddressVerifyViewController {
    
    // Klavye açıldığında yapılan işlemler
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
        
        // Aktif text field'i kontrol et
        if !aRect.contains(houseTextField.frame.origin) {
            scrollView.scrollRectToVisible(houseTextField.frame, animated: true)
        }
    }
    
    // Klavye kapanışını takip eden işlemler
    @objc func keyboardWillDisappear(notification: Notification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}
