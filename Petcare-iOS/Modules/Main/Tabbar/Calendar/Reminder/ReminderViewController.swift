//
//  ReminderViewController.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 17.03.2024.
//

import UIKit

protocol ReminderViewProtocol: AnyObject { }

final class ReminderViewController: UIViewController {
    var presenter: ReminderPresenterProtocol!
    
    private lazy var startTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Start Reminder"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var startTimeTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Start Time"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var endTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "End Reminder"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var endTimeTextfield: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "End Time"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var reminderPet: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Which reminder pets ?"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    private lazy var reminderSubject: MyTextField = {
        let textfield = MyTextField()
        textfield.placeholder = "Select subject"
        textfield.tintColor = AppColors.primaryColor
        return textfield
    }()
    
    
    //MARK: AllStackView
    fileprivate lazy var dateStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 12
        return stack
    }()
    
    //MARK: AllStackView
    fileprivate lazy var startStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    
    //MARK: AllStackView
    fileprivate lazy var endStackView: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        return stack
    }()
    
    
    private lazy var doneButton: AppButton = {
        let appbutton = AppButton.build()
            .setTitle("Done")
            .setBackgroundColor(AppColors.primaryColor)
        appbutton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return appbutton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildLayout()
        prepareTitleLabel()
        presenter.viewDidLoad()
        view.backgroundColor = AppColors.bgColor
        
        startTextfield.delegate = self
        endTextfield.delegate = self
        startTextfield.setInputViewDatePicker(target: self, selector: #selector(startTapped))
        endTextfield.setInputViewDatePicker(target: self, selector: #selector(endTapped))
        
        startTimeTextfield.setInputViewTimePicker(target: self, selector: #selector(startTimeTapped))
        endTimeTextfield.setInputViewTimePicker(target: self, selector: #selector(endTimeTapped))
        
        let petSubject = ["Yaklaşan aşı tarihi hatırlatma", "Beslenme öğün hatırlama", "Gezintiye çıkma zamanı", "Uyku vakti", "Diğer"]
        
        let availablePets = ["Lolo", "Doggy", "Holosko", "Bobi", "Şirine", "Boncuk ama köpek olan"]
        
        reminderPet.setInputViewBottomSheet(options: availablePets, target: self, selector: #selector(handlePets(_:)))
        reminderSubject.setInputViewBottomSheet(options: petSubject, target: self, selector: #selector(handleSubject(_:)))
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // Selector metodu
    @objc func handlePets(_ selectedOption: String) {
        reminderPet.text = selectedOption
    }
    
    @objc func handleSubject(_ selectedOption: String) {
        reminderSubject.text = selectedOption
    }
    
    @objc func startTapped() {
        let datePicker = startTextfield.inputView as? UIDatePicker
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        
        if let selectedDate = datePicker?.date {
            startTextfield.text = dateformatter.string(from: selectedDate)
        }
        startTextfield.resignFirstResponder()
    }
    
    @objc private func buttonTapped() {
        print("Done button clicked")
        
    }
    
    @objc func endTapped() {
        let datePicker = endTextfield.inputView as? UIDatePicker
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        
        if let selectedDate = datePicker?.date {
            endTextfield.text = dateformatter.string(from: selectedDate)
        }
        endTextfield.resignFirstResponder()
    }
    
    
    @objc func startTimeTapped() {
        let datePicker = startTimeTextfield.inputView as? UIPickerView
        let selectedHour = datePicker?.selectedRow(inComponent: 0) // Seçilen saat
        let selectedMinute = datePicker?.selectedRow(inComponent: 1) // Seçilen dakika
        
        let formattedTime = "\(selectedHour ?? 0):\(selectedMinute == 0 ? "00" : "30")"
        startTimeTextfield.text = formattedTime
        
        startTimeTextfield.resignFirstResponder()
    }
    
    @objc func endTimeTapped() {
        let datePicker = endTimeTextfield.inputView as? UIPickerView
        let selectedHour = datePicker?.selectedRow(inComponent: 0) // Seçilen saat
        let selectedMinute = datePicker?.selectedRow(inComponent: 1) // Seçilen dakika
        
        let formattedTime = "\(selectedHour ?? 0):\(selectedMinute == 0 ? "00" : "30")"
        endTimeTextfield.text = formattedTime
        
        endTimeTextfield.resignFirstResponder()
    }
    
    private func prepareTitleLabel() {
        let titleLabel = TitleLabel.configurationTitleLabel(withText: "Reminder", fontSize: 17, textColor: AppColors.primaryColor)
        navigationItem.titleView = titleLabel
    }
}
extension ReminderViewController: ViewCoding {
    func setupView() {
        
    }
    
    func setupHierarchy() {
        view.addSubview(dateStackView)
        
        dateStackView.addArrangedSubview(reminderPet)
        dateStackView.addArrangedSubview(reminderSubject)
        dateStackView.addArrangedSubview(startStackView)
        dateStackView.addArrangedSubview(endStackView)
        
        startStackView.addArrangedSubview(startTextfield)
        startStackView.addArrangedSubview(startTimeTextfield)
        
        endStackView.addArrangedSubview(endTextfield)
        endStackView.addArrangedSubview(endTimeTextfield)
        
        view.addSubview(doneButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            dateStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dateStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            doneButton.topAnchor.constraint(equalTo: dateStackView.bottomAnchor, constant: 20),
            doneButton.leadingAnchor.constraint(equalTo: dateStackView.leadingAnchor, constant: 20),
            doneButton.trailingAnchor.constraint(equalTo: dateStackView.trailingAnchor, constant: -20),
        ])
    }
}

extension ReminderViewController: UITextFieldDelegate {
    
}
