//
//  UITextField + Extension.swift
//  Petcare-iOS
//
//  Created by Kenan Baylan on 4.01.2024.
//

import UIKit
import Combine

extension UITextField {
    
    func validatedText(validationType: ValidatorsType) throws -> String {
        let validator = ValidatorFactorys.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
    
    func setInputViewTimePicker(target: Any, selector: Selector) {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels // İsteğe bağlı olarak farklı bir stil seçebilirsiniz
        timePicker.sizeToFit()
        
        self.inputView = timePicker
        
        // Toolbar oluşturma
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor.blue
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        
        toolbar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: UIScreen.screenHeight / 3))
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        
        datePicker.sizeToFit()
        
        
        self.inputView = datePicker
        
        //CreateToolbar
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.screenWidth, height: 45))
        toolbar.barStyle = .default
        toolbar.isTranslucent = true
        toolbar.tintColor = AppColors.primaryColor
        toolbar.sizeToFit()
        toolbar.sizeToFit()
        
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: .done, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .done, target: nil, action: selector)
        
        toolbar.isUserInteractionEnabled = true
        toolbar.setItems([cancel,flexible,barButton], animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
  
    func setInputViewBottomSheet(options: [String], target: Any, selector: Selector, title: String?) {
        let bottomSheetView = BottomSheetView(frame: CGRect(x: 0, y: UIScreen.screenHeight, width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2.5), title: title ?? "test")
        bottomSheetView.options = options
        bottomSheetView.didSelectOption = { selectedOption in
            self.text = selectedOption
            if let target = target as? UIViewController {
                target.perform(selector, with: selectedOption)
            }
        }
        self.inputView = bottomSheetView
    }
}

extension UITextView {
    func setInputAccessoryView() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolbar.items = [spacer, doneButton]
        
        self.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        self.resignFirstResponder()
    }
}
