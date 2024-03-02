//
//  CustomTextfield.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 2.03.2024.
//


import Foundation
import UIKit
import Combine

final class CustomTextField: UIView {
    
    var padding: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5.wPercent, bottom: 0, right: 10.wPercent)
    }
    
    lazy var textField: PaddedTextField = {
        let textField = PaddedTextField(frame: .zero)
        textField.padding = padding
        textField.textColor = .label
        textField.borderStyle = .none
        textField.layer.borderColor = AppColors.borderColor?.cgColor ?? UIColor.red.cgColor
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    private lazy var errorLabel: CustomLabel = {
        let label = CustomLabel(text: "error", fontSize: 12, fontType: .regular, textColor: AppColors.customRed)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var expandingVstack: CustomStackView = {
        let stack = CustomStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fill
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Properties
    private var viewModel: ViewModel
    private var focusState: FocusState = .active {
        didSet {
            focusStateChanged()
        }
    }
    
    private var subscriptions = Set<AnyCancellable>()
    @Published var validationState: ValidationState = .idle
    
    // MARK: - LifeCycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        listen()
        constraintSetup()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        startValidation()
    }
    // MARK: - setup
    private func setup() {
        textField.isSecureTextEntry = viewModel.isSecure
        textField.placeholder = viewModel.placeholder
        textField.keyboardType = viewModel.keyboardType
        textField.autocapitalizationType = viewModel.autoCap
        textField.layer.cornerRadius = 12
    }
    private func constraintSetup() {
        addSubview(expandingVstack)
        expandingVstack.addArrangedSubview(textField)
        expandingVstack.addArrangedSubview(errorLabel)
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 50),
            errorLabel.widthAnchor.constraint(equalTo: widthAnchor),
            
            expandingVstack.topAnchor.constraint(equalTo: topAnchor),
            expandingVstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            expandingVstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            expandingVstack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    // MARK: - Methods
    private func focusStateChanged() {
        textField.layer.borderColor = focusState.borderColor
        textField.layer.borderWidth = focusState.borderWidth
    }
    
    func validationStateChanged(state: ValidationState) {
        switch state {
        case .idle:
            errorLabel.text = nil
            errorLabel.isHidden = true
        case .error(let errorState):
            if textField.text?.isEmpty == false {
                errorLabel.text = errorState.description
                errorLabel.isHidden = false
            } else {
                if focusState == .inActive {
                    errorLabel.text = errorState.description
                    errorLabel.isHidden = false
                }
                errorLabel.text = nil
                errorLabel.isHidden = true
            }
        case .valid:
            errorLabel.text = nil
            errorLabel.isHidden = true
        }
    }
    
    private func listen() {
        $validationState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.validationStateChanged(state: state)
            }.store(in: &subscriptions)
    }
}

// MARK: - Validator
extension CustomTextField: Validator {
    private func startValidation() {
        guard validationState == .idle, let validationType = ValidatorType(rawValue: viewModel.type.rawValue) else { return }
        
        textField.textPublisher()
            .removeDuplicates()
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .validateText(validationType: validationType)
            .assign(to: &$validationState)
        
        NotificationCenter.default.post(
            name: UITextField.textDidChangeNotification,
            object: textField
        )
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        focusState = .active
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        focusState = .inActive
    }
}
