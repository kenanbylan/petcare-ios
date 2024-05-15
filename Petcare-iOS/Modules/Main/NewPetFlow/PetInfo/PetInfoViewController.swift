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
    
    private lazy var petsNameTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Pet name"
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
    
    private lazy var weightTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Weight (kg)"
        textfield.keyboardType = .decimalPad
        return textfield
    }()
    
    private lazy var heightTextField: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Height (cm)"
        textfield.keyboardType = .numberPad
        return textfield
    }()
    
    private lazy var conversationTextView: CustomTextView = {
        return CustomTextView.Builder()
            .text("Info: ")
            .textColor(AppColors.labelColor)
            .font(AppFonts.medium.font(size: 14))
            .shadowOffset(CGSize(width: 2, height: 2))
            .cornerRadius(12)
            .borderWidth(2)
            .borderColor(AppColors.borderColor)
            .height(UIScreen.screenWidth / 2)
            .build()
    }()
    
    //MARK: BUİLDER PATTERN
    private lazy var appButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("Continue")
            .setTitleColor(AppColors.customWhite)
            .setImage(UIImage(named: "coffee")?.resized(to: CGSize(width: 25, height: 25)))
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(appButtonClicked), for: .touchUpInside)
        return appbutton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        
        setupKeyboardDismissRecognizer()
        self.dateBirthTextfield.setInputViewDatePicker(target: self, selector: #selector(tapDone))
    }
    
    @objc func tapDone() {
        let datePicker = self.dateBirthTextfield.inputView as? UIDatePicker
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        
        if let selectedDate = datePicker?.date {
            let formattedDate = dateformatter.string(from: selectedDate)
            presenter?.selectedDateTime = selectedDate // Seçilen tarihi presenter'a atayabilirsiniz
            self.dateBirthTextfield.text = formattedDate
        }
        self.dateBirthTextfield.resignFirstResponder()
        
    }
    
    override func keyboardWillShow(with height: CGFloat) {
        scrollView.contentSize.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }
    
    override func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
}

//MARK: - Button Action
extension PetInfoViewController {
    
    @objc func appButtonClicked() {
        validate()
    }
    
    func validate() {
        do {
            let petName = try petsNameTextfield.validatedText(validationType: ValidatorsType.requiredField(field: "Pets Name"))
            let height = try heightTextField.validatedText(validationType: ValidatorsType.requiredField(field: "Height "))
            let weight = try self.weightTextField.validatedText(validationType: ValidatorsType.requiredField(field: "Weight"))
            let genderIndex = genderSegmentedControl.selectedSegmentIndex
            let petGenre = presenter?.selectedGenderType(index: genderIndex)
            let petInfo = conversationTextView.text
            
            let data = PetInfoModel(gender: petGenre, type: presenter?.selectedPet, name: petName , weight: weight, height: height, birthDate: presenter?.selectedDateTime,specialInfo: petInfo)
        
            presenter?.savePetInfo(data)
            presenter?.navigateSelectPetImage()
            
        } catch(let error) {
            showAlert(for: (error as! ValidationError).message)
        }
    }
}

extension PetInfoViewController: PetInfoViewProtocol {
    func prepareUI() {
        view.backgroundColor = AppColors.bgColor
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: presenter!.title, fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
    
}

extension PetInfoViewController: ViewCoding {
    func setupView() {}
    
    func setupHierarchy() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(allStackView)
        self.contentView.addSubview(appButton)
        
        let views: [UIView] = [genderSegmentedControl,petsNameTextfield,dateBirthTextfield,hStackView, conversationTextView]
        for i in views { allStackView.addArrangedSubview(i) }
        
        hStackView.addArrangedSubview(weightTextField)
        hStackView.addArrangedSubview(heightTextField)
        
        let hConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        hConstraint.priority = .defaultLow
        hConstraint.isActive = true
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            
            conversationTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
